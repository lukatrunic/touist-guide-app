import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_guide_app/dependency_injection.dart';
import 'package:tourist_guide_app/presentation/auth/screen/sign_in_screen.dart';
import 'package:tourist_guide_app/presentation/core/app_router.dart';
import 'package:tourist_guide_app/presentation/core/style/extensions.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageContext = context;
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text("My profile", style: context.textTitle),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // AVATAR
              CircleAvatar(
                radius: 45,
                backgroundImage: const AssetImage(
                  'assets/images/profile_placeholder.png',
                ),
                backgroundColor: Colors.grey.shade200,
              ),

              const SizedBox(height: 16),

              // NAME
              Text(
                user?.displayName ??
                    (email.isNotEmpty ? nameFromEmail(email) : "User"),
                style: context.textSubtitle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              // EMAIL
              Text(user?.email ?? "no email", style: context.textLabel),

              const Spacer(),

              // DEACTIVATE
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _showDeactivateDialog(pageContext, ref);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: context.colorGradientEnd,
                    side: BorderSide(color: context.colorGradientEnd),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text("Deactivate", style: context.textLabel),
                ),
              ),

              const SizedBox(height: 12),

              // SIGN OUT
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(authenticationNotifierProvider.notifier)
                        .signOut();

                    if (!context.mounted) return;

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                      (route) => false, // clears whole app stack
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: context.colorGradientEnd,
                  ),
                  child: Text("Sign out", style: context.textButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDeactivateDialog(
    BuildContext pageContext,
    WidgetRef ref,
  ) async {
    return showDialog(
      context: pageContext,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Deactivate account"),
          content: const Text(
            "Are you sure you want to deactivate your account? "
            "This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(); // close
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // close
                await _deactivateAccount(pageContext, ref);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text("Yes, deactivate"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deactivateAccount(BuildContext context, WidgetRef ref) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await user.delete(); // delete Firebase user
      await FirebaseAuth.instance.signOut(); // sign out

      ref.read(authenticationNotifierProvider.notifier).signOut();

      if (!context.mounted) return;

      Navigator.of(
        context,
        rootNavigator: true,
      ).pushNamedAndRemoveUntil(AppRouter.signInScreen, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.code == 'requires-recent-login'
                ? "Please re-login before deactivating your account."
                : "Something went wrong.",
          ),
        ),
      );
    }
  }

  String nameFromEmail(String email) {
    final localPart = email.split('@').first;

    final parts = localPart
        .replaceAll(RegExp(r'[._\-]'), ' ')
        .split(' ')
        .where((p) => p.isNotEmpty)
        .toList();

    return parts.map((p) => p[0].toUpperCase() + p.substring(1)).join(' ');
  }
}
