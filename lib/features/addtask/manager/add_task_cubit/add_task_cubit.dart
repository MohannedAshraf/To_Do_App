import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/features/addtask/data/repo/add_task_repo.dart';
import 'package:to_do_app/features/addtask/manager/add_task_cubit/add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInit());

  static AddTaskCubit get(context) => BlocProvider.of(context);
  TextEditingController title = TextEditingController();
  TextEditingController describtion = TextEditingController();
  AddTaskRepo addTaskRepo = AddTaskRepo();
  GlobalKey<FormState> formKey = GlobalKey();
  void addTask() async {
    emit(AddTaskLoading());
    var response = await addTaskRepo.addTask(
      title: title.text,
      describtion: describtion.text,
    );
    response.fold((e) => emit(AddTaskError(e)), (r) => emit(AddTaskSucsses()));
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }
}
