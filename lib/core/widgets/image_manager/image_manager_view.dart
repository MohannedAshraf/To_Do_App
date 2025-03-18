import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/core/widgets/image_manager/image_manager_cubit.dart';
import 'package:to_do_app/core/widgets/image_manager/image_manager_state.dart';

class ImageManagerView extends StatelessWidget {
  const ImageManagerView({
    super.key,
    required this.selectedImageBuilder,
    required this.unSelectedImageBuilder,
    required this.onSelected,
  });

  final Widget Function(XFile image) selectedImageBuilder;
  final Widget Function() unSelectedImageBuilder;
  final void Function(XFile image) onSelected;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageManagerCubit(),
      child: BlocConsumer<ImageManagerCubit, ImageManagerState>(
        listener: (context, state) {
          if (state is ImageManagerSeletImage) {
            onSelected(state.image);
          }
        },
        builder: (context, state) {
          return InkWell(
            onTap: ImageManagerCubit.get(context).selectImage,
            child: Builder(
              builder: (context) {
                if (state is ImageManagerSeletImage) {
                  return selectedImageBuilder(state.image);
                } else {
                  return unSelectedImageBuilder();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
