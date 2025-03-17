import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/core/widgets/image_manager/image_manager_state.dart';

class ImageManagerCubit extends Cubit<ImageManagerState> {
  static ImageManagerCubit get(context) => BlocProvider.of(context);
  ImageManagerCubit() : super(ImageManagerInit());

  Future selectImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      emit(ImageManagerSeletImage(selectedImage));
    }
  }
}
