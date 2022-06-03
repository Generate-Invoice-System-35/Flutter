import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/widgets/bottom_navigator.dart';
import 'package:flutter_capstone_project/widgets/home_carousel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            HomeCarousel(),
            SizedBox(
              height: 200,
            ),
            Container(
              height: 20,
              width: 20,
              color: Colors.red,
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigator(),
    );
  }
}
