import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz_app/MoreScreens/loading.dart';

class Thinkcell extends StatefulWidget {
  const Thinkcell({super.key});

  @override
  State<Thinkcell> createState() => _ThinkcellState();
}

class _ThinkcellState extends State<Thinkcell> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoadingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Image.asset('assets/thinkcell.png', fit: BoxFit.cover),
      ),
    );
  }
}
