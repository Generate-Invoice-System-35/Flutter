import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/stack.dart';
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
  uploadFragment,
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

  List<StackList<FragmentEnum>> activeFragment = List.generate(3, (index) => StackList());

  void navigateToFragment({required FragmentEnum fragmentEnum}) {
    activeFragment[untrackedCurrentIdx].push(fragmentEnum);
    notifyListeners();
  }

  void pop() {
    activeFragment[untrackedCurrentIdx].pop();
    notifyListeners();
  }

  bool isEmpty() {
    return activeFragment[untrackedCurrentIdx].isEmpty;
  }

  FragmentEnum? top() {
    return isEmpty() ? null : activeFragment[untrackedCurrentIdx].peek;
  }
}
