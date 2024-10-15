import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });

    return const Scaffold(
      body: Center(
        child: Text('Welcome to\nthe E-Commerce App',
            style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
