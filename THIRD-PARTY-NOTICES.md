# Third-party notices

ImportaMI is released under the [MIT License](LICENSE). It includes or uses the following third-party works,
each under its own license.

## Places365 scene-recognition model

The file `models/resnet18_places365.onnx` is the ResNet18 model trained on Places365-Standard and released by
Bolei Zhou and MIT CSAIL Computer Vision in the [Places365 project](https://github.com/CSAILVision/places365)
([Places project page](http://places2.csail.mit.edu)).

- License: the pretrained Places365 models are released under the
  **Creative Commons Attribution license (CC BY)**; the project's code is under the MIT License.
- Changes: the original PyTorch model was converted to the ONNX format to run with ONNX Runtime.
- Citation:

  > Bolei Zhou, Agata Lapedriza, Aditya Khosla, Aude Oliva, Antonio Torralba.
  > *Places: A 10 million Image Database for Scene Recognition.*
  > IEEE Transactions on Pattern Analysis and Machine Intelligence, 2017.
  > [PDF](http://places2.csail.mit.edu/PAMI_places.pdf)

The copyright of the images in the Places dataset belongs to their owners. ImportaMI does not include any of them.

## Libraries

| Library | License |
|---|---|
| [Avalonia UI](https://github.com/AvaloniaUI/Avalonia) | MIT |
| [Inter font](https://github.com/rsms/inter) (via Avalonia.Fonts.Inter) | SIL Open Font License 1.1 |
| [.NET Community Toolkit](https://github.com/CommunityToolkit/dotnet) (CommunityToolkit.Mvvm) | MIT |
| [MetadataExtractor](https://github.com/drewnoakes/metadata-extractor-dotnet) | Apache License 2.0 |
| [ONNX Runtime](https://github.com/microsoft/onnxruntime) | MIT |
| [SkiaSharp](https://github.com/mono/SkiaSharp) | MIT |
| [.NET runtime](https://github.com/dotnet/runtime) and System.IO.Hashing | MIT |
| [Velopack](https://github.com/velopack/velopack) | MIT |

The full license texts are in each project's repository at the links above.
