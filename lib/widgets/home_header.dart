import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 52),
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
          clipBehavior: Clip.none,
          children: [
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
              child: Image(
                image: AssetImage(
                  "assets/images/business-person.png",
                ),
                height: 532,
                width: 330,
              ),
            ),
            const Positioned(
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
            Positioned(
              bottom: -24,
              left: MediaQuery.of(context).size.width / 3,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                      gradient: ColorConstant.orangeGradient,
                      borderRadius: const BorderRadius.all(Radius.circular(16))),
                  child: const Text(
                    "Start Now. It’s Free!",
                    style:
                        TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
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
