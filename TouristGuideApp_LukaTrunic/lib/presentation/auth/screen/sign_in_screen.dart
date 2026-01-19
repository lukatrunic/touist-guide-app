import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/presentation/auth/notifier/state/authentication_state.dart';
import 'package:tourist_guide_app/presentation/auth/widget/custom_text_field.dart';
import 'package:tourist_guide_app/presentation/core/router/app_router.dart';
import '../../core/style/extensions.dart';
import '../../core/style/text_styles.dart';
import '../../core/widget/custom_action_button.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final RegExp REG_EXP_EMAIL = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  final RegExp REG_EXP_PASS = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authenticationNotifierProvider);

    ref.listen(authenticationNotifierProvider, (_, currentState) {
      if (currentState is AuthenticatedState) {
        Navigator.of(context).pushReplacementNamed(AppRouter.homeScreen);
      }

      if (currentState is ErrorState) {
        ErrorSnackBar.show(context, 'There was an error');
      }
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset("assets/images/sign_in_image.png", height: 275),
                const SizedBox(height: 20),
                Text(
                  "Please sign in to your account.",
                  style: Theme.of(context).textTheme.textFieldTextStyle,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  placeholder: "Email",
                  controller: _emailController,
                  validator: isEmailValid,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  placeholder: "Password",
                  controller: _passwordController,
                  validator: isPasswordValid,
                  isPasswordType: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Forgot password?", style: context.textLabel),
                  ],
                ),
                const SizedBox(height: 30),
                CustomActionButton(
                  text: "Sign in",
                  isLoading: state is LoadingState,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      ref
                          .read(authenticationNotifierProvider.notifier)
                          .signIn(
                            _emailController.text,
                            _passwordController.text,
                          );
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?", style: context.textSubtitle),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRouter.signUpScreen);
                      },
                      child: Text(
                        "Sign up",
                        style: context.textSubtitle.copyWith(
                          color: context.colorLink,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? isEmailValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }

    if (!REG_EXP_EMAIL.hasMatch(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? isPasswordValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!REG_EXP_PASS.hasMatch(value)) {
      return 'Password must contain letters, numbers, and at least one special character';
    }

    return null;
  }
}

class ErrorSnackBar {
  static void show(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colorError,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.info_outline, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: context.colorError,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: context.colorError, width: 2),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      duration: const Duration(seconds: 4),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
