import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/home/home_screen.dart';
import 'package:lostnfound/presentation/login/login_screen.dart';
import 'package:lostnfound/provider/auth_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(authControllerProvider.notifier).loadSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    return MaterialApp(
      title: 'Lost & Found',
      theme: AppTheme.lightTheme,
      home: auth.isLoggedIn ? const HomeScreen() : LoginScreen(),
    );
  }
}
