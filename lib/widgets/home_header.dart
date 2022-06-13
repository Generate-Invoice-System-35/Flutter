import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/shadow.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  void onNavigateLogin(BuildContext context) {
    context.read<FragmentManager>().navigateToFragment(fragmentEnum: FragmentEnum.loginFragment);
  }

  void onNavigateRegister(BuildContext context) {
    context.read<FragmentManager>().navigateToFragment(fragmentEnum: FragmentEnum.registerFragment);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      height: 320,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 24,
            left: 0,
            right: 0,
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                color: ColorConstant.homeHeaderBg,
                image: const DecorationImage(
                  image: AssetImage("assets/images/gradient-bg.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(36), bottomRight: Radius.circular(36)),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage(
                "assets/images/logo.png",
              ),
              height: 35,
              width: 86,
            ),
          ),
          const Positioned(
            bottom: 24,
            left: 20,
            child: Image(
              image: AssetImage(
                "assets/images/business-person.png",
              ),
              height: 536 / 2,
              width: 532 / 2,
              fit: BoxFit.cover,
            ),
          ),
          const Positioned(
            top: 100,
            right: 0,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text("Find the convenience of\n online invoicing here.",
                  textAlign: TextAlign.end, style: TypographyConstant.h1),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientButton(
                  "Sign Up",
                  gradient: ColorConstant.greyGradient,
                  onTap: () => onNavigateRegister(context),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: [ShadowConstant.boxShadow1],
                  padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 14),
                  textStyle:
                      TypographyConstant.button1.merge(TextStyle(color: ColorConstant.darkBlue)),
                ),
                const SizedBox(width: 46),
                GradientButton(
                  "Sign In",
                  gradient: ColorConstant.orangeGradient,
                  onTap: () => onNavigateLogin(context),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: [ShadowConstant.boxShadow1],
                  padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 14),
                  textStyle:
                      TypographyConstant.button1.merge(TextStyle(color: ColorConstant.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
