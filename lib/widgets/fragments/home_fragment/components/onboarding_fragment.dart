import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/widgets/home_carousel.dart';
import 'package:flutter_capstone_project/widgets/home_header.dart';

class OnboardingFragment extends StatefulWidget {
  const OnboardingFragment({Key? key}) : super(key: key);

  @override
  State<OnboardingFragment> createState() => _OnboardingFragmentState();
}

class _OnboardingFragmentState extends State<OnboardingFragment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          color: ColorConstant.white,
          child: Column(
            children: [
              const HomeHeader(),
              const HomeCarousel(),
              const SizedBox(
                height: 180,
              ),
              Container(
                height: 200,
                width: 20,
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
