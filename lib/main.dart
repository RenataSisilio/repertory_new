import 'package:flutter/material.dart';

import 'design/color_scheme.dart';
import 'modules/home/category/category_page.dart';
import 'modules/home/home_page.dart';
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
      initialRoute: '/splash',
      routes: {
        '/': (context) => const HomePage(),
        '/splash': (context) => const SplashPage(),
        '/category': (context) {
          final category =
              (ModalRoute.of(context)?.settings.arguments as String?) ?? '';
          return CategoryPage(category);
        },
      },
      // themeMode: ThemeMode.light,
    );
  }
}
