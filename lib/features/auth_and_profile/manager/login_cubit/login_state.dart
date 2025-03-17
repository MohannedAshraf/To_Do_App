import 'package:to_do_app/features/auth_and_profile/data/model/user_model.dart';

abstract class LoginState {}

class LoginInit extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  String error;
  LoginError(this.error);
}

class LoginSuccess extends LoginState {
  UserModel user;
  LoginSuccess(this.user);
}
