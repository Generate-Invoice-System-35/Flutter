import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_svg/svg.dart';

class BottomBar {
  SvgPicture icon;
  String text;
  Widget child;
  double scale;
  double selectedScale;
  BottomBar({
    required this.icon,
    required this.text,
    required this.child,
    required this.scale,
    required this.selectedScale,
  });
}

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final animationDuration = 100;
  int _curPageIdx = 0;

  List<BottomBar> pages = [
    BottomBar(
      icon: SvgPicture.asset('assets/icons/home.svg'),
      text: "Home",
      child: Container(),
      scale: 1,
      selectedScale: 1,
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/dashboard.svg'),
      text: "Dashboard",
      child: Container(),
      scale: 1,
      selectedScale: 1,
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/profile.svg'),
      text: "Profile",
      child: Container(),
      scale: 1,
      selectedScale: 1,
    ),
  ];

  void handleChangeBar({required int targetIndex, required int currentIndex}) {
    List<BottomBar> pagesTemp = pages;
    for (var e in pagesTemp) {
      e.scale = 1;
    }
    pagesTemp[targetIndex].scale = 0;
    pagesTemp[targetIndex].selectedScale = 1;

    pagesTemp[currentIndex].selectedScale = 0;
    pagesTemp[currentIndex].scale = 1;
    setState(() {
      pages = pagesTemp;
    });
    Future.delayed(Duration(milliseconds: animationDuration), () {
      setState(() {
        _curPageIdx = targetIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 30,
              offset: const Offset(0, 3),
              blurStyle: BlurStyle.outer, // changes position of shadow
            ),
          ],
          borderRadius:
              const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
          border: const Border(
              top: BorderSide(
            width: 0,
            style: BorderStyle.none,
          )),
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _curPageIdx,
          height: 70,
          onDestinationSelected: (targetIndex) =>
              handleChangeBar(targetIndex: targetIndex, currentIndex: _curPageIdx),
          destinations: pages
              .asMap()
              .entries
              .map(
                (e) => NavigationDestination(
                  icon: AnimatedScale(
                    scale: e.value.scale,
                    duration: Duration(milliseconds: animationDuration),
                    child: e.value.icon,
                    // onEnd: () => setState(() {}),
                  ),
                  label: e.value.text,
                  selectedIcon: AnimatedScale(
                    scale: e.value.selectedScale,
                    duration: Duration(milliseconds: animationDuration),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: ColorConstant.orangeGradient,
                          borderRadius: const BorderRadius.all(Radius.circular(16))),
                      padding: const EdgeInsets.only(top: 9, right: 22, left: 22, bottom: 10),
                      child: Text(e.value.text,
                          style: TextStyle(
                            color: ColorConstant.white,
                            fontSize: 14,
                          )),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
