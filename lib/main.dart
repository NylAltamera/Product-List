import 'package:flutter/material.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const FStoreApp());
}

class FStoreApp extends StatelessWidget {
  const FStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product List Viewer',
      theme: ThemeData(
        fontFamily: 'Poppins',
        fontFamilyFallback: ['Arial', 'Roboto'],
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
