abstract class UpdateState {}

class UpdateInit extends UpdateState {}

class UpdateLoading extends UpdateState {}

class UpdateSuccess extends UpdateState {
  String msg;
  UpdateSuccess(this.msg);
}

class UpdateError extends UpdateState {
  String error;
  UpdateError(this.error);
}
