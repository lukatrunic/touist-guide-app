import 'package:flutter/material.dart';

import '../style/extensions.dart';

class CustomActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const CustomActionButton({super.key, required this.onPressed, this.isLoading = false});

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
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
            "Sign in",
            style: context.textButton,
        ),
      ),
    );
  }
}
