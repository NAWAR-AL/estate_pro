import 'package:estate_pro/features/auth/presentation/pages/register_page.dart';
import 'package:estate_pro/features/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
     
      
      home:  HomePage(),
    );
  }
}



