<#
.SYNOPSIS
    Crea l'installer di ImportaMI per il sistema su cui gira.

.DESCRIPTION
    Pubblica l'app self-contained (non serve .NET sul PC dell'utente) e la impacchetta con Velopack:
      Windows -> ImportaMI-win-Setup.exe   (installazione per utente, senza permessi di amministratore)
      macOS   -> ImportaMI-osx-Setup.pkg
      Linux   -> ImportaMI.AppImage
    Ogni installer va creato sul suo sistema: per averli tutti e tre usa la GitHub Action "Installer".
    Il risultato finisce in artifacts/releases/<rid>.

.EXAMPLE
    ./build/package.ps1
    ./build/package.ps1 -Runtime osx-arm64 -Version 1.0.1
#>
param(
    [string]$Runtime,
    [string]$Version
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$project = Join-Path $root 'src/ImportaMI.App/ImportaMI.App.csproj'
$brand = Join-Path $root 'docs/brand'

$onWindows = $env:OS -eq 'Windows_NT'
$onMac = -not $onWindows -and (uname) -eq 'Darwin'

if (-not $Runtime) {
    $arm = [System.Runtime.InteropServices.RuntimeInformation]::OSArchitecture -eq 'Arm64'
    $arch = if ($arm) { 'arm64' } else { 'x64' }
    $os = if ($onWindows) { 'win' } elseif ($onMac) { 'osx' } else { 'linux' }
    $Runtime = "$os-$arch"
}
if (-not $Version) {
    $Version = ([xml](Get-Content $project -Raw)).Project.PropertyGroup.Version | Where-Object { $_ } | Select-Object -First 1
}

$publishDir = Join-Path $root "artifacts/publish/$Runtime"
$releaseDir = Join-Path $root "artifacts/releases/$Runtime"

switch -Wildcard ($Runtime) {
    'win-*'   { $mainExe = 'ImportaMI.exe'; $icon = 'importami.ico' }
    'osx-*'   { $mainExe = 'ImportaMI';     $icon = 'importami.icns' }
    'linux-*' { $mainExe = 'ImportaMI';     $icon = 'importami-512.png' }
    default   { throw "Runtime non supportato: $Runtime" }
}

Write-Host "ImportaMI $Version per $Runtime" -ForegroundColor Cyan

if (Test-Path $publishDir) { Remove-Item $publishDir -Recurse -Force }
dotnet publish $project -c Release -r $Runtime --self-contained true -p:Version=$Version -o $publishDir
if ($LASTEXITCODE) { throw 'dotnet publish non riuscito' }

dotnet tool restore
if ($LASTEXITCODE) { throw 'dotnet tool restore non riuscito' }

dotnet vpk pack `
    --packId ImportaMI `
    --packVersion $Version `
    --packTitle ImportaMI `
    --packAuthors 'Mistere Tech' `
    --packDir $publishDir `
    --mainExe $mainExe `
    --icon (Join-Path $brand $icon) `
    --runtime $Runtime `
    --outputDir $releaseDir
if ($LASTEXITCODE) { throw 'vpk pack non riuscito' }

Write-Host "Installer pronto in $releaseDir" -ForegroundColor Green
Get-ChildItem $releaseDir | Format-Table Name, Length
