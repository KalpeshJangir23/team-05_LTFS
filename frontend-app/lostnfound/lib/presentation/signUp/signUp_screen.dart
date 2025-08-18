import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/model/user_model.dart';
import 'package:lostnfound/presentation/home/home_screen.dart';
import 'package:lostnfound/provider/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _psNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (prev, next) {
      if (next.isLoggedIn) {
        Navigator.pop(context); // Go back to login or home
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!)),
        );
      }
    });

    final auth = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Top Image
                  Image.asset(
                    'assets/lost.jpg',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),

                  // Title
                  Text(
                    "Create Your Account",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        AppInputDecoration.rounded(hintText: "Enter your name" , labelText: "Name"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // PS Number Field
                  TextFormField(
                    controller: _psNumberController,
                    decoration: AppInputDecoration.rounded(
                        hintText: "Enter your PS number" , labelText: "PS number"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "PS number is required";
                      }
                      if (value.length < 5) {
                        return "PS number must be at least 5 characters";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: AppInputDecoration.rounded(labelText: "Email",
                        hintText: "Enter your email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                      decoration: AppInputDecoration.rounded(labelText: "Password",
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

                  // Sign Up Button
                  GestureDetector(
                    onTap: auth.loading
                        ? 
                          null
                          : (){
                            if (_formKey.currentState!.validate()) {
                              final user = UserModel(
                                psid: _psNumberController.text.trim(),
                                email: _emailController.text.trim(),
                                name: _nameController.text.trim(),
                               // isAdmin: false,
                                password: _passwordController.text.trim(),
                              );
                              ref
                                  .read(authControllerProvider.notifier)
                                  .signUp(user);
                            }
                          
                        // : () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => HomeScreen(),
                        //       ),
                        //     );
                            // if (_formKey.currentState!.validate()) {
                            //   final user = UserModel(
                            //     psid: _psNumberController.text.trim(),
                            //     email: _emailController.text.trim(),
                            //     name: _nameController.text.trim(),
                            //     isAdmin: false,
                            //     password: _passwordController.text.trim(),
                            //   );
                            //   ref
                            //       .read(authControllerProvider.notifier)
                            //       .signUp(user);
                            // }
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

                  // Already have an account
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Already have an account? Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
