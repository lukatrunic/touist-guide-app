import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:tourist_guide_app/presentation/auth/widget/custom_text_field.dart';
import 'package:tourist_guide_app/presentation/sights/screen/main_navigation_screen.dart';
import '../../../dependency_injection.dart';
import '../../core/style/extensions.dart';
import '../../core/style/text_styles.dart';
import '../../core/widget/custom_action_button.dart';
import '../notifier/state/authentication_state.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticationNotifierProvider, (previous, state) {
      if (state is AuthenticatedState) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const MainNavigationScreen(),
          ),
              (route) => false,
        );
      }

      if (state is ErrorState) {
        ErrorSnackBar.show(context, state.errorMessage);
      }
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        shadowColor: Colors.black.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text("Register"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/sign_in_image.png",
                  height: 160,
                ),
                const SizedBox(height: 20),
                Text(
                  "Please create an account to continue.",
                  style: Theme.of(context).textTheme.textFieldTextStyle,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  placeholder: "Email",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  placeholder: "Password",
                  controller: _passwordController,
                  isPasswordType: true,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  placeholder: "Confirm password",
                  controller: _confirmPasswordController,
                  isPasswordType: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    }
                    if (value != _passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                CustomActionButton(
                  text: "Sign up",
                  isLoading:
                  ref.watch(authenticationNotifierProvider) is LoadingState,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(authenticationNotifierProvider.notifier)
                          .signUp(
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
                    Text(
                      "Already have an account?",
                      style: context.textSubtitle,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Sign in",
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
}


