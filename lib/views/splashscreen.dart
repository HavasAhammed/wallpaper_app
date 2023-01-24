import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallpaper_hub/views/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home())));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white12,
      body: Center(
        child: Image(
          image: AssetImage('assets/wallpaperhub.png'),
        ),
      ),
    );
  }
}
