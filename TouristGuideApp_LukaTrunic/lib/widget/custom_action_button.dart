import 'package:flutter/material.dart';
import 'package:tourist_guide_app/style/extensions.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [context.colorGradientBegin, context.colorGradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: () {},
        child: Text(
            "Sign in",
            style: context.textButton,
        ),
      ),
    );
  }
}
