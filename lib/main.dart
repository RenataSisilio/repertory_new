import 'package:flutter/material.dart';

import 'design/color_scheme.dart';
import 'modules/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Repertory',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SplashPage(),
      // themeMode: ThemeMode.light,
    );
  }
}
