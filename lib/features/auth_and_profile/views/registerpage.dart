import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/Core/resources_manager/app_colors.dart';
import 'package:to_do_app/Core/resources_manager/app_images.dart';
import 'package:to_do_app/core/resources_manager/app_strings.dart';
import 'package:to_do_app/core/widgets/image_manager/image_manager_view.dart';
import 'package:to_do_app/core/widgets/mytextbutton.dart';
import 'package:to_do_app/core/widgets/mytextformfield.dart';
import 'package:to_do_app/features/auth_and_profile/manager/register_cubit/register_cubit.dart';
import 'package:to_do_app/features/auth_and_profile/manager/register_cubit/register_state.dart';
import 'package:to_do_app/features/auth_and_profile/views/loginpage.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final TextEditingController confirmpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Builder(
            builder: (context) {
              return Form(
                key: RegisterCubit.get(context).formKey,
                child: Column(
                  children: [
                    ImageManagerView(
                      onSelected: (XFile image) {},
                      selectedImageBuilder: (XFile image) {
                        return Container(
                          width: double.infinity,
                          height: 298,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            image: DecorationImage(
                              image: FileImage(File(image.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      unSelectedImageBuilder: () {
                        return Container(
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
                        );
                      },
                    ),
                    MyTextFormField(
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
                      top: 23,
                      controller: RegisterCubit.get(context).username,
                      maxlines: 1,
                      hinttext: MyAppStrings.namehint,
                      labeltext: MyAppStrings.name,
                    ),
                    MyTextFormField(
                      validator: (String? textpass) {
                        String error;

                        if (textpass != null) {
                          if (textpass.isNotEmpty) {
                            if (textpass.length >= 6) {
                              return null;
                            } else {
                              error = 'Password must be more than 5';
                            }
                          } else {
                            error = "Password mustn't be  empty";
                          }
                        } else {
                          error = 'You must assign Password';
                        }
                        return error;
                      },
                      controller: RegisterCubit.get(context).password,
                      maxlines: 1,
                      hinttext: MyAppStrings.passwordhint,
                      labeltext: MyAppStrings.password,
                    ),
                    MyTextFormField(
                      validator: (String? textcon) {
                        String error;
                        if (textcon != null) {
                          if (textcon.isNotEmpty) {
                            // ignore: unrelated_type_equality_checks
                            if (textcon !=
                                RegisterCubit.get(context).password) {
                              return null;
                            } else {
                              error =
                                  'Confirm password  must be  equal password';
                            }
                          } else {
                            error = 'Confirm password must be not empty';
                          }
                        } else {
                          error = 'You must confirm Password';
                        }
                        return error;
                      },
                      controller: confirmpass,
                      maxlines: 1,
                      hinttext: MyAppStrings.confirmpasshint,
                      labeltext: MyAppStrings.confirmpass,
                    ),
                    BlocConsumer<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                        if (state is RegisterLoading) {
                          return CircularProgressIndicator();
                        }
                        return MyTextButton(
                          onpressed: RegisterCubit.get(context).onRegister,
                          offsety: 4,
                          shadowcolor: MyColors.gray,
                          buttontext: MyAppStrings.register.toUpperCase(),
                          newscreen: LoginPage(),
                        );
                      },
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.msg)));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        } else if (state is RegisterError) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                    ),

                    SizedBox(height: 40.99),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(MyAppStrings.haveacc),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },

                          child: Text(
                            MyAppStrings.login,
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
