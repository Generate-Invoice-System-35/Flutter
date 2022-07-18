import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/overlay_manager.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/shadow.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_text.dart';
import 'package:provider/provider.dart';

class ProfileUpdatedOverlay extends StatefulWidget {
  const ProfileUpdatedOverlay({Key? key}) : super(key: key);

  @override
  State<ProfileUpdatedOverlay> createState() => _ProfileUpdatedOverlayState();
}

class _ProfileUpdatedOverlayState extends State<ProfileUpdatedOverlay>
    with TickerProviderStateMixin {
  void close(BuildContext context) {
    Provider.of<OverlayManager>(context, listen: false)
        .switchOverlay(overlayEnum: OverlayEnum.none);
  }

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
              width: MediaQuery.of(context).size.width - 80,
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 8),
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "Your profile have successfully saved!",
                      textAlign: TextAlign.center,
                      style: TypographyConstant.profileUpdated.merge(
                        const TextStyle(decorationThickness: 0, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  GradientButton(
                    "OK",
                    height: 40,
                    width: 80,
                    gradient: ColorConstant.orangeGradient,
                    onTap: () => close(context),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [ShadowConstant.boxShadow1],
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    textStyle:
                        TypographyConstant.button2.merge(TextStyle(color: ColorConstant.white)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
