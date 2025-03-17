import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth_and_profile/data/repo/profile_repo.dart';
import 'package:to_do_app/features/auth_and_profile/manager/change_cubit/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInit());
  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  ProfileRepo repo = ProfileRepo();

  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController newpasswordconfirm = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  void onChangePassword() async {
    if (validate()) {
      emit(ChangePasswordLoading());
      var response = await repo.changepassword(
        currentpassword: currentpassword.text,
        newpassword: newpassword.text,
        newpasswordconfirm: newpasswordconfirm.text,
      );
      response.fold(
        (error) {
          emit(ChangePasswordError(error));
        },
        (r) {
          emit(ChangePasswordSuccess(r!));
        },
      );
    }
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }
}
