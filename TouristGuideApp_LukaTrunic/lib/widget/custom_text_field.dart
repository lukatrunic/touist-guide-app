import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;

  const CustomTextField({super.key, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red)
        ),
      ),
    );
  }
}
