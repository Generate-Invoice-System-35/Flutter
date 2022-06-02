import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_svg/svg.dart';

class BottomBar {
  SvgPicture icon;
  String text;
  Widget child;
  BottomBar({required this.icon, required this.text, required this.child});
}

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _curPageIdx = 0;

  final List<BottomBar> pages = [
    BottomBar(
      icon: SvgPicture.asset('assets/icons/home.svg'),
      text: "Home",
      child: Container(),
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/dashboard.svg'),
      text: "Dashboard",
      child: Container(),
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/profile.svg'),
      text: "Profile",
      child: Container(),
    ),
  ];

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
          onDestinationSelected: (newIdx) => setState(() => _curPageIdx = newIdx),
          destinations: pages
              .map(
                (e) => NavigationDestination(
                  icon: e.icon,
                  label: e.text,
                  selectedIcon: Container(
                    decoration: BoxDecoration(
                        gradient: ColorConstant.orangeGradient,
                        borderRadius: const BorderRadius.all(Radius.circular(16))),
                    padding: const EdgeInsets.only(top: 9, right: 22, left: 22, bottom: 10),
                    child: Text(e.text,
                        style: TextStyle(
                          color: ColorConstant.white,
                          fontSize: 14,
                        )),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
