import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/Core/resources_manager/app_icons.dart';
import 'package:to_do_app/features/start/views/startpage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void navigateToStartPage(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => StartPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToStartPage(context);
    });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 60),
              Container(
                width: 334,
                height: 433,
                margin: const EdgeInsets.only(left: 20),
                child: SvgPicture.asset(Myicons.splash),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
