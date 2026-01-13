import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/presentation/core/app_router.dart';
import '../../core/style/extensions.dart';
import '../../core/style/text_styles.dart';
import '../../core/widget/custom_action_button.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  ConsumerState<VerifyEmailScreen> createState() =>
      _VerifyEmailScreenState();
}

class _VerifyEmailScreenState
    extends ConsumerState<VerifyEmailScreen> {
  bool isEmailSent = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _sendVerificationEmail();

    // Check every 3 seconds if email is verified
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _checkEmailVerified();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      setState(() => isEmailSent = true);
    }
  }

  Future<void> _checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.reload();

    if (user != null && user.emailVerified) {
      _timer?.cancel();
      Navigator.of(context).pushReplacementNamed(
        AppRouter.homeScreen,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        shadowColor: Colors.black.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text("Verify email"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              Image.asset(
                "assets/images/verify_email.png", // 👈 add image
                height: 200,
              ),

              const SizedBox(height: 30),

              Text(
                "Please check your inbox and verify your email address.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.textFieldTextStyle,
              ),

              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive an email?",
                    style: context.textSubtitle,
                  ),
                  TextButton(
                    onPressed: _sendVerificationEmail,
                    child: Text(
                      "Resend",
                      style: context.textSubtitle.copyWith(
                        color: context.colorLink,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              if (isEmailSent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: context.colorLink),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline,
                          color: context.colorLink),
                      const SizedBox(width: 8),
                      Text(
                        "Email resent.",
                        style: context.textSubtitle.copyWith(
                          color: context.colorLink,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
