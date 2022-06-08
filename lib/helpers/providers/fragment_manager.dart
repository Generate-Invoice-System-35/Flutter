import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/services/local_storage.dart';
import 'package:flutter_capstone_project/widgets/bottom_navigator.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/index.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/index.dart';
import 'package:flutter_capstone_project/widgets/fragments/profile_fragment/index.dart';
import 'package:flutter_svg/svg.dart';

enum FragmentEnum {
  loginFragment,
  registerFragment,
  onboardingFragment,
  invoiceFragment,
  none,
}

class FragmentManager with ChangeNotifier {
  int untrackedCurrentIdx = 0;
  final List<BottomBar> _pages = [
    BottomBar(
      icon: SvgPicture.asset('assets/icons/home.svg'),
      text: "Home",
      child: const HomeFragment(0),
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/dashboard.svg'),
      text: "Dashboard",
      child: const DashboardFragment(1),
    ),
    BottomBar(
      icon: SvgPicture.asset('assets/icons/profile.svg'),
      text: "Profile",
      child: const ProfileFragment(2),
    ),
  ];
  List<BottomBar> get pages => _pages;

  List<FragmentEnum> activeFragment = List.generate(3, (index) => FragmentEnum.none);

  void updateFragmentByIndex({required int idx, required FragmentEnum fragmentEnum}) {
    activeFragment[idx] = fragmentEnum;
    notifyListeners();
  }
}
