import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Core/resources_manager/app_colors.dart';
import 'package:to_do_app/Core/resources_manager/app_images.dart';
import 'package:to_do_app/core/resources_manager/app_strings.dart';
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
                      controller: RegisterCubit.get(context).username,
                      maxlines: 1,
                      hinttext: MyAppStrings.namehint,
                      labeltext: MyAppStrings.name,
                    ),
                    MyTextFormField(
                      controller: RegisterCubit.get(context).password,
                      maxlines: 1,
                      hinttext: MyAppStrings.passwordhint,
                      labeltext: MyAppStrings.password,
                    ),
                    MyTextFormField(
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
