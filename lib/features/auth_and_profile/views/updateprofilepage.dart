import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Core/resources_manager/app_colors.dart';
import 'package:to_do_app/Core/resources_manager/app_images.dart';
import 'package:to_do_app/core/resources_manager/app_strings.dart';
import 'package:to_do_app/core/widgets/mytextformfield.dart';
import 'package:to_do_app/features/auth_and_profile/manager/update_cubit/update_cubit.dart';
import 'package:to_do_app/features/auth_and_profile/manager/update_cubit/update_state.dart';
import 'package:to_do_app/features/home/views/new_home_page.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateCubit(),
      child: Scaffold(
        body: Builder(
          builder: (context) {
            return Form(
              key: UpdateCubit.get(context).formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 298,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: AssetImage(MyImages.palastine),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    MyTextFormField(
                      controller: UpdateCubit.get(context).username,
                      maxlines: 1,
                      hinttext: MyAppStrings.namehint,
                      labeltext: MyAppStrings.name,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 331,
                      height: 48.01,
                      margin: EdgeInsets.only(left: 22, right: 20, top: 30),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: MyColors.gray2.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(14),
                        color: MyColors.green,
                      ),
                      child: BlocConsumer<UpdateCubit, UpdateState>(
                        listener: (context, state) {
                          if (state is UpdateSuccess) {
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(SnackBar(content: Text(state.msg)));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewHomepage(),
                              ),
                            );
                          } else if (state is UpdateError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is UpdateLoading) {
                            return CircularProgressIndicator();
                          }
                          return TextButton(
                            onPressed: () {
                              UpdateCubit.get(context).upDate();
                            },
                            child: Text(
                              MyAppStrings.save,
                              style: TextStyle(
                                color: MyColors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

//  return MyTextButton(
//                       offsety: 4,
//                       shadowcolor: MyColors.gray2,
//                       buttontext: "Save",
//                       newscreen: HomeBeforTasks(),
//                     );
