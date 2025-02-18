import 'package:dojo_flutter/constants/constants.dart';
import 'package:dojo_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TmdbApp());
}

class TmdbApp extends StatelessWidget {
  const TmdbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeConstants.primaryColor,
          primary: ThemeConstants.primaryColor,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(
        title: 'Popular',
      ),
    );
  }
}
