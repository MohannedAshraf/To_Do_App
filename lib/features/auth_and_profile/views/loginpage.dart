import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Core/resources_manager/app_colors.dart';
import 'package:to_do_app/Core/resources_manager/app_images.dart';

import 'package:to_do_app/core/resources_manager/app_strings.dart';
import 'package:to_do_app/core/widgets/mytextformfield.dart';
import 'package:to_do_app/features/auth_and_profile/manager/login_cubit/login_cubit.dart';
import 'package:to_do_app/features/auth_and_profile/views/registerpage.dart';
import 'package:to_do_app/features/home/views/homepagebeforaddingtask.dart';

import '../manager/login_cubit/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              return Form(
                key: LoginCubit.get(context).formKey,
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
                    MyTextFormField(
                      top: 23,
                      controller: LoginCubit.get(context).username,
                      maxlines: 1,
                      hinttext: MyAppStrings.namehint,
                      labeltext: MyAppStrings.name,
                      validator: (String? text) {
                        String error;
                        if (text != null) {
                          if (text.isNotEmpty) {
                            if (text.length >= 4) {
                              return null;
                            } else {
                              error = 'Username must be more than 3';
                            }
                          } else {
                            error = 'Username must be not empty';
                          }
                        } else {
                          error = 'You must assign username';
                        }
                        return error;
                      },
                    ),
                    MyTextFormField(
                      validator: (String? text) {
                        String error;
                        if (text != null) {
                          if (text.isNotEmpty) {
                            if (text.length >= 6) {
                              return null;
                            } else {
                              error = 'Password must be more than 5';
                            }
                          } else {
                            error = 'Password must be not empty';
                          }
                        } else {
                          error = 'You must assign Password';
                        }
                        return error;
                      },
                      controller: LoginCubit.get(context).password,
                      maxlines: 1,
                      hinttext: MyAppStrings.passwordhint,
                      labeltext: MyAppStrings.password,
                    ),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Login Success')),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeBeforTasks(),
                            ),
                          );
                        } else if (state is LoginError) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return CircularProgressIndicator();
                        }
                        return Container(
                          width: 331,
                          height: 48.01,
                          margin: EdgeInsets.only(left: 22, right: 22, top: 30),
                          decoration: BoxDecoration(
                            color: MyColors.green,
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
                          ),
                          child: TextButton(
                            onPressed: () {
                              LoginCubit.get(context).onloginPressed();
                            },
                            child: Text(
                              MyAppStrings.login.toUpperCase(),
                              style: TextStyle(color: MyColors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    // MyTextButton(
                    //   offsety: 4,
                    //   shadowcolor: MyColors.gray,
                    //   buttontext: MyAppStrings.login,
                    //   newscreen: HomeBeforTasks(),
                    // ),
                    SizedBox(height: 40.99),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(MyAppStrings.nohaveacc),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            MyAppStrings.register,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
