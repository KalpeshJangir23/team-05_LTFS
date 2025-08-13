import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/model/user_model.dart';

import 'package:lostnfound/provider/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _psNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (prev, next) {
      if (next.isLoggedIn) {
        Navigator.pop(context); // go back to login or home
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              TextField(
                controller: _nameController,
                decoration:
                    AppInputDecoration.rounded(hintText: "Enter your name"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _psNumberController,
                decoration: AppInputDecoration.rounded(
                    hintText: "Enter your PS number"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration:
                    AppInputDecoration.rounded(hintText: "Enter your email"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration:
                    AppInputDecoration.rounded(hintText: "Enter your password"),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: auth.loading
                    ? null
                    : () {
                        final user = UserModel(
                          psid: _psNumberController.text.trim(),
                          email: _emailController.text.trim(),
                          name: _nameController.text.trim(),
                          isAdmin: false,
                          password: _passwordController.text.trim(),
                        );
                        ref.read(authControllerProvider.notifier).signUp(user);
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
                          "Sign Up",
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
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(color: AppTheme.containerLost),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
