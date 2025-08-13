import 'package:flutter/material.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/login/login_screen.dart';

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
      home: LoginScreen()
    );
  }
}
