import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/Core/resources_manager/app_colors.dart';
import 'package:to_do_app/Core/resources_manager/app_images.dart';
import 'package:to_do_app/core/resources_manager/app_strings.dart';
import 'package:to_do_app/core/widgets/mytextbutton.dart';
import 'package:to_do_app/core/widgets/mytextformfield.dart';
import 'package:to_do_app/features/auth_and_profile/manager/change_cubit/change_password_cubit.dart';
import 'package:to_do_app/features/auth_and_profile/manager/change_cubit/change_password_state.dart';
import 'package:to_do_app/features/home/views/new_home_page.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key, formkey});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return Form(
            key: ChangePasswordCubit.get(context).formKey,
            child: Scaffold(
              body: SingleChildScrollView(
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
                      controller:
                          ChangePasswordCubit.get(context).currentpassword,
                      maxlines: 1,
                      hinttext: MyAppStrings.oldpasshint,
                      labeltext: MyAppStrings.oldpass,
                    ),
                    MyTextFormField(
                      controller: ChangePasswordCubit.get(context).newpassword,
                      maxlines: 1,
                      hinttext: MyAppStrings.newpasshint,
                      labeltext: MyAppStrings.newpass,
                    ),
                    MyTextFormField(
                      controller:
                          ChangePasswordCubit.get(context).newpasswordconfirm,
                      maxlines: 1,
                      hinttext: MyAppStrings.confirmpasshint,
                      labeltext: MyAppStrings.confirmpass,
                    ),
                    BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                      listener: (context, state) {
                        if (state is ChangePasswordSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('change pasasword Success')),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewHomepage(),
                            ),
                          );
                        } else if (state is ChangePasswordError) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is ChangePasswordLoading) {
                          return CircularProgressIndicator();
                        }
                        return MyTextButton(
                          onpressed: () {
                            ChangePasswordCubit.get(context).onChangePassword();
                          },

                          offsety: 4,
                          shadowcolor: MyColors.gray,
                          buttontext: MyAppStrings.changepassword,
                          newscreen: NewHomepage(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
