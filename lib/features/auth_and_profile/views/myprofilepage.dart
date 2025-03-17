import 'package:flutter/material.dart';
import 'package:to_do_app/Core/resources_manager/app_icons.dart';
import 'package:to_do_app/core/widgets/customappbar.dart';
import 'package:to_do_app/core/widgets/profilecontainer.dart';
import 'package:to_do_app/features/auth_and_profile/views/changepass.dart';
import 'package:to_do_app/features/auth_and_profile/views/updateprofilepage.dart';
import 'package:to_do_app/features/settings/views/settingspage.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: Column(
        children: [
          ProfileContainer(
            icon1p: Myicons.profile,
            textp: '   Update Profile',
            nextscreen: UpdateProfilePage(),
          ),
          ProfileContainer(
            icon1p: Myicons.lock,
            textp: "    Chagce Password",
            nextscreen: ChangePasswordPage(),
          ),
          ProfileContainer(
            icon1p: Myicons.setting,
            textp: "    Settings",
            nextscreen: Settingspage(),
          ),
        ],
      ),
    );
  }
}
