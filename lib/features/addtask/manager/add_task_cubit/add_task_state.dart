abstract class AddTaskState {}

class AddTaskInit extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskSucsses extends AddTaskState {}

class AddTaskError extends AddTaskState {
  String error;
  AddTaskError(this.error);
}
