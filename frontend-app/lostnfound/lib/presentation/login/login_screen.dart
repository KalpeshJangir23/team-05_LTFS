import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/signUp/signUp_screen.dart';
import 'package:lostnfound/presentation/home/home_screen.dart';
import 'package:lostnfound/provider/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _psidController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (prev, next) {
      if (next.isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) =>  HomeScreen()),
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image on top
                Image.asset(
                  'assets/lnf.jpg',
                  height: 150,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 30),

                // PSID Field
                TextFormField(
                  controller: _psidController,
                  decoration:
                      AppInputDecoration.rounded(hintText: "Enter your PSID"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "PSID is required";
                    }
                    if (value.length < 5) {
                      return "PSID must be at least 5 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passController,
                  decoration: AppInputDecoration.rounded(
                      hintText: "Enter your password"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Login Button
                GestureDetector(
                  onTap: auth.loading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(authControllerProvider.notifier)
                                .login(
                                  psid: _psidController.text.trim(),
                                  password: _passController.text.trim(),
                                );
                          }
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

                // Create Account
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SignUpScreen()),
                  ),
                  child: const Text(
                    "Create an account",
                    style: TextStyle(color: AppTheme.containerLost),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
