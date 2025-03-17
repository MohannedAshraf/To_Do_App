import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/auth_and_profile/data/repo/profile_repo.dart';
import 'package:to_do_app/features/auth_and_profile/manager/update_cubit/update_state.dart';

class UpdateCubit extends Cubit<UpdateState> {
  static UpdateCubit get(context) => BlocProvider.of(context);
  UpdateCubit._internal() : super(UpdateInit());
  static final UpdateCubit _instance = UpdateCubit._internal();
  factory UpdateCubit() => _instance;

  TextEditingController username = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  ProfileRepo repo = ProfileRepo();
  void upDate() async {
    if (validate()) {
      emit(UpdateLoading());
      var response = await repo.update(username: username.text);

      response.fold(
        (error) {
          emit(UpdateError(error));
        },
        (r) {
          emit(UpdateSuccess(r!));
        },
      );
    }
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }
}
