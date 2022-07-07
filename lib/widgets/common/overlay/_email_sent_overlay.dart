import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_circular_indicator.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/sent.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Emails have been sent",
                    style: TypographyConstant.emailSent.merge(
                      TextStyle(
                        color: ColorConstant.white,
                        decorationThickness: 0,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
