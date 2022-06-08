import 'package:flutter/material.dart';
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

  const GradientButton(
    this.text, {
    Key? key,
    this.boxShadow,
    this.borderRadius = BorderRadius.zero,
    this.textStyle = TypographyConstant.button1,
    this.padding = EdgeInsets.zero,
    this.height,
    required this.gradient,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
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
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
