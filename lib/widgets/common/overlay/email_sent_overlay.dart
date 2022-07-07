import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_text.dart';

class EmailSentOverlay extends StatefulWidget {
  const EmailSentOverlay({Key? key}) : super(key: key);

  @override
  State<EmailSentOverlay> createState() => _EmailSentOverlayState();
}

class _EmailSentOverlayState extends State<EmailSentOverlay> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      top: 0,
      child: Container(
          color: Colors.black.withOpacity(0.33),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 8),
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/sent.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: GradientText(
                      "Emails have been sent",
                      gradient: ColorConstant.orangeGradient,
                      textAlign: TextAlign.center,
                      style: TypographyConstant.h2.merge(
                        const TextStyle(decorationThickness: 0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
