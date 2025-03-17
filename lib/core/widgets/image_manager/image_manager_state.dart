import 'package:image_picker/image_picker.dart';

abstract class ImageManagerState {}

class ImageManagerInit extends ImageManagerState {}

class ImageManagerSeletImage extends ImageManagerState {
  XFile image;
  ImageManagerSeletImage(this.image);
}
