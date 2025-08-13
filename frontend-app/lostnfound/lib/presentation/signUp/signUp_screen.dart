import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _psNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              TextField(
                controller: _nameController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter your name",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _psNumberController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter your PS number",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter your email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter your password",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  // Handle Sign Up action here
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppTheme.containerLost, // From your theme colors
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
