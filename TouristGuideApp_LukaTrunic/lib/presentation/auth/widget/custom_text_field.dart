import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isPasswordType;

  const CustomTextField({
    super.key,
    required this.placeholder,
    required this.controller,
    this.validator,
    this.isPasswordType = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPasswordType && !isPasswordVisible,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        suffixIcon: widget.isPasswordType
          ? IconButton(
            icon: isPasswordVisible ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
            onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible)
        )
        : null,
      ),
    );
  }
}
