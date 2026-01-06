import 'package:flutter/material.dart';
import 'package:tourist_guide_app/widget/custom_text_field.dart';

import '../../style/text_styles.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset("assets/images/sign_in_image.png", height: 275),
              const SizedBox(height: 20),
              Text(
                "Please sign in to your account.",
                style: Theme.of(context).textTheme.textFieldTextStyle,
              ),
              const SizedBox(height: 40),
              CustomTextField(placeholder: "Email",),
              const SizedBox(height: 20),
              CustomTextField(placeholder: "Password",),
              Text(
                "Forgot password?",
                style: Theme.of(context).textTheme.subtitleTextStyle,
              ),
              ElevatedButton(onPressed: () {}, child: Text("Sign in")),
              Text("Don't have an account? Sign up"),
            ],
          ),
        ),
      ),
    );
  }
}
