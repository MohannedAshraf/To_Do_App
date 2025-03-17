import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/features/auth_and_profile/data/repo/profile_repo.dart';
import 'package:to_do_app/features/auth_and_profile/manager/register_cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterCubit._internal() : super(RegisterInit());
  static final RegisterCubit _instance = RegisterCubit._internal();
  factory RegisterCubit() => _instance;
  ProfileRepo repo = ProfileRepo();

  XFile? image;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  void setImage(XFile image) {
    this.image = image;
  }

  void onRegister() async {
    if (validate()) {
      emit(RegisterLoading());
      var response = await repo.register(
        username: username.text,
        password: password.text,
      );
      response.fold(
        (error) {
          emit(RegisterError(error));
        },
        (r) {
          emit(RegisterSuccess(r!));
        },
      );
    }
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }
}
