import 'package:flutter/material.dart';
import 'package:pomodoro/core/app_theme.dart';
import 'package:pomodoro/features/timer/pages/home.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer Pomodoro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      themeMode: ThemeMode.light,
      home: const HomePage(),
    );
  }
}
