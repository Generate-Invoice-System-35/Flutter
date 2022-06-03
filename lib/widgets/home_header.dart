import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      // decoration: BoxDecoration(
      //   color: Colors.blue[900],
      // ),
      height: 341,
      width: double.infinity,
      child: SafeArea(
        child: Stack(
          children: const [
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage(
                  "assets/images/logo.png",
                ),
                height: 35,
                width: 86,
              ),
            ),
            Positioned(
              child: Image(
                image: AssetImage(
                  "assets/images/business-person.png",
                ),
                height: 532,
                width: 330,
              ),
            ),
            Positioned(
              top: 100,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  "Find the convenience of\n online invoicing here.",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
