import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';

class GradientButton extends StatelessWidget {
  final Gradient gradient;
  final VoidCallback onTap;
  final List<BoxShadow>? boxShadow;
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final String text;
  final double? height;
  final double? width;
  bool loading;

  GradientButton(
    this.text, {
    Key? key,
    this.boxShadow,
    this.borderRadius = BorderRadius.zero,
    this.textStyle = TypographyConstant.button1,
    this.padding = EdgeInsets.zero,
    this.height,
    this.width,
    this.loading = false,
    required this.gradient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        boxShadow: boxShadow,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          minimumSize: Size.zero,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: textStyle,
            ),
            loading
                ? Container(
                    width: 16,
                    height: 16,
                    margin: const EdgeInsets.only(left: 8),
                    child: CircularProgressIndicator(
                      backgroundColor: ColorConstant.white,
                      color: ColorConstant.orangeLight,
                      strokeWidth: 2,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
