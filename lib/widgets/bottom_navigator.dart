import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/shadow.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_svg/svg.dart';

class BottomBar {
  SvgPicture icon;
  String text;
  Widget child;
  BottomBar({
    required this.icon,
    required this.text,
    required this.child,
  });
}

class AnimatedBottomBar extends BottomBar {
  double scale;
  double selectedScale;
  AnimatedBottomBar({
    required icon,
    required text,
    required child,
    required this.scale,
    required this.selectedScale,
  }) : super(child: child, icon: icon, text: text);
}

class BottomNavigator extends StatefulWidget {
  final List<BottomBar> pages;
  int curPage;
  void Function(int) onChangePage;
  BottomNavigator(
      {Key? key, required this.pages, required this.curPage, required this.onChangePage})
      : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final animationDuration = 150;

  late List<AnimatedBottomBar> animatedPages = [
    ...widget.pages
        .map(
          (e) => AnimatedBottomBar(
              icon: e.icon, text: e.text, child: e.child, scale: 1, selectedScale: 1),
        )
        .toList()
  ];

  void handleChangeBar({required int targetIndex, required int currentIndex}) {
    List<AnimatedBottomBar> pagesTemp = animatedPages;
    for (var e in pagesTemp) {
      e.scale = 1;
    }
    pagesTemp[currentIndex].selectedScale = 0;
    pagesTemp[currentIndex].scale = 1;

    pagesTemp[targetIndex].scale = 0;
    pagesTemp[targetIndex].selectedScale = 1;

    setState(() {
      animatedPages = pagesTemp;
    });
    Future.delayed(Duration(milliseconds: animationDuration), () {
      widget.onChangePage(targetIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: const NavigationBarThemeData(),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [ShadowConstant.boxShadow1],
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
          selectedIndex: widget.curPage,
          height: 70,
          onDestinationSelected: (targetIndex) =>
              handleChangeBar(targetIndex: targetIndex, currentIndex: widget.curPage),
          destinations: animatedPages
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
                          style: TypographyConstant.button1
                              .merge(TextStyle(color: ColorConstant.white))),
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
