import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_circular_indicator.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat(max: 1);
    // _animationController.forward();
    super.initState();
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
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: GradientCircularProgressIndicator(
                radius: MediaQuery.of(context).size.width / 3.5,
                gradientColors: [
                  ColorConstant.white,
                  ColorConstant.orangeSolid,
                ],
                strokeWidth: 20.0,
              ),
            ),
          )),
    );
  }
}
