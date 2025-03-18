import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Core/resources_manager/app_images.dart';
import 'package:to_do_app/core/resources_manager/app_colors.dart';
import 'package:to_do_app/core/resources_manager/app_strings.dart';
import 'package:to_do_app/core/widgets/mytextformfield.dart';
import 'package:to_do_app/features/addtask/manager/add_task_cubit/add_task_cubit.dart';
import 'package:to_do_app/features/addtask/manager/add_task_cubit/add_task_state.dart';
import 'package:to_do_app/features/addtask/manager/get_task_cubit/get_tasks_cubit.dart';
import 'package:to_do_app/features/home/views/new_home_page.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTaskCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          title: Text(MyAppStrings.addtasktitle),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Container(
                  width: 261,
                  height: 207,
                  margin: EdgeInsets.only(bottom: 29),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(MyImages.palastine),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                MyTextFormField(
                  validator: (String? title) {
                    String error;
                    if (title != null) {
                      return null;
                    } else {
                      error = "title mustn't be empty";
                    }
                    return error;
                  },
                  controller: AddTaskCubit.get(context).title,
                  maxlines: 1,
                  hinttext: MyAppStrings.titlehint,
                  labeltext: MyAppStrings.title,
                ),
                MyTextFormField(
                  validator: (String? descrebtion) {
                    String error;
                    if (descrebtion != null) {
                      return null;
                    } else {
                      error = "title mustn't be  empty";
                    }
                    return error;
                  },
                  controller: AddTaskCubit.get(context).describtion,
                  maxlines: 1,
                  hinttext: MyAppStrings.descriptionhint,
                  labeltext: MyAppStrings.description,
                ),
                BlocConsumer<AddTaskCubit, AddTaskState>(
                  listener: (context, state) {
                    if (state is AddTaskSucsses) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task Added Sucssefuly")),
                      );
                      GetTasksCubit.get(context).getTasks();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NewHomepage()),
                      );
                    } else if (state is AddTaskError) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      width: 331,
                      height: 48.01,
                      margin: EdgeInsets.only(left: 22, right: 22, top: 30),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: MyColors.gray.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(14),
                        color: MyColors.green,
                      ),
                      child: TextButton(
                        onPressed: () {
                          AddTaskCubit.get(context).addTask();
                        },
                        child: Text(
                          MyAppStrings.addtasktitle,
                          style: TextStyle(
                            color: MyColors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
