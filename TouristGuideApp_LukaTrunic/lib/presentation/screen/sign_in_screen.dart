import 'package:flutter/material.dart';
import 'package:tourist_guide_app/style/extensions.dart';
import 'package:tourist_guide_app/widget/custom_action_button.dart';
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
              CustomTextField(placeholder: "Email"),
              const SizedBox(height: 20),
              CustomTextField(placeholder: "Password"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: context.textLabel,
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              CustomActionButton(),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: context.textSubtitle,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign up",
                      style: context.textSubtitle.copyWith(color: context.colorLink),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
