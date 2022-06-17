import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/gradient-bg.png',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RotatedBox(
              quarterTurns: 2,
              child: Image.asset(
                'assets/images/gradient-bg.png',
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width / 2.5,
            ),
          ),
        ],
      ),
    );
  }
}
