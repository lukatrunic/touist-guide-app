import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:tourist_guide_app/presentation/core/app_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      ref.read(authenticationNotifierProvider.notifier).checkAuthStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthenticationState>(
      authenticationNotifierProvider,
          (_, state) {
        if (state is AuthenticatedState) {
          Navigator.of(context)
              .pushReplacementNamed(AppRouter.homeScreen);
        } else if (state is EmptyState) {
          Navigator.of(context)
              .pushReplacementNamed(AppRouter.signInScreen);
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/camping_image.png'),
              Lottie.asset(
                'assets/animations/loading_dots.json',
                width: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

