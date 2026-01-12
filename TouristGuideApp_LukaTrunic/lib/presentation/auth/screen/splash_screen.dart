import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_guide_app/presentation/core/app_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    redirectToTheNextScreen(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/camping_image.png'),
              Lottie.asset('assets/animations/loading_dots.json', width: 120),
            ],
          ),
        ),
      ),
    );
  }

  void redirectToTheNextScreen(BuildContext context) async{
    await Future.delayed(const Duration(seconds: 2));
    Navigator.of(context).pushReplacementNamed(AppRouter.signInScreen);
  }
}
