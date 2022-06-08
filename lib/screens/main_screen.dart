import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/widgets/bottom_navigator.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/index.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/index.dart';
import 'package:flutter_capstone_project/widgets/fragments/profile_fragment/index.dart';
import 'package:flutter_capstone_project/widgets/home_carousel.dart';
import 'package:flutter_capstone_project/widgets/home_header.dart';
import 'package:flutter_svg/svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int curPage = 0;
  List<BottomBar> pages = [
    BottomBar(
      icon: SvgPicture.asset('assets/icons/home.svg'),
      text: "Home",
      child: const HomeFragment(),
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/dashboard.svg'),
      text: "Dashboard",
      child: const DashboardFragment(),
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/profile.svg'),
      text: "Profile",
      child: const ProfileFragment(),
    ),
  ];
  void handleChangePage(int page) {
    setState(() => curPage = page);
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      // extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/gradient-bg.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          pages[curPage].child,
        ],
      ),
      bottomNavigationBar: BottomNavigator(
        pages: pages,
        curPage: curPage,
        onChangePage: handleChangePage,
      ),
    );
  }
}
