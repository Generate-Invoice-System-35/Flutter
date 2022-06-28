import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
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
            mainAxisSize: MainAxisSize.max,
            children: [
              const HomeHeader(),
              const HomeCarousel(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 0.6 * MediaQuery.of(context).size.width,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Convert quotes into",
                          style: TextStyle(
                            color: ColorConstant.darkBlue,
                            height: 1.5,
                          ).merge(TypographyConstant.h1)),
                      TextSpan(
                          text: " invoices ",
                          style: TextStyle(
                                  height: 1.5,
                                  foreground: Paint()
                                    ..shader = ColorConstant.orangeGradient
                                        .createShader(const Rect.fromLTWH(0, 0, 200, 70)))
                              .merge(TypographyConstant.h1)),
                      TextSpan(
                          text: "with easy and simple steps.",
                          style: TextStyle(
                            color: ColorConstant.darkBlue,
                            height: 1.5,
                          ).merge(TypographyConstant.h1)),
                    ])),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 0.8 * MediaQuery.of(context).size.width,
                child: const Text(
                  'Automatically bill based on sales orders, supply orders, contracts, or time and materials.',
                  textAlign: TextAlign.center,
                  style: TypographyConstant.body,
                ),
              ),
              Image.asset(
                "assets/images/invoice-preview.png",
                width: 0.7 * MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
