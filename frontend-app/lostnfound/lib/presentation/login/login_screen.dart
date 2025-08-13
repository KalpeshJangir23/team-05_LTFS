import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/signUp/signUp_screen.dart';
import 'package:lostnfound/presentation/home/home_screen.dart';
import 'package:lostnfound/provider/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _psidController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (prev, next) {
      if (next.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    final auth = ref.watch(authControllerProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _psidController,
              decoration:
                  AppInputDecoration.rounded(hintText: "Enter your PSID"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passController,
              decoration:
                  AppInputDecoration.rounded(hintText: "Enter your password"),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: auth.loading
                  ? null
                  : () {
                      ref.read(authControllerProvider.notifier).login(
                            psid: _psidController.text.trim(),
                            password: _passController.text.trim(),
                          );
                    },
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.containerLost,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: auth.loading
                    ? const CircularProgressIndicator()
                    : Text(
                        "Login",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SignUpScreen()),
              ),
              child: const Text(
                "Create an account",
                style: TextStyle(color: AppTheme.containerLost),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
