import 'package:flutter/material.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/home/home_screen.dart';
import 'package:lostnfound/presentation/login/login_screen.dart';
import 'package:lostnfound/presentation/signUp/signUp_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        home: SignUpScreen());
  }
}
