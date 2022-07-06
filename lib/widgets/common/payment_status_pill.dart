import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';

class PaymentStatusPill extends StatelessWidget {
  final int status;
  const PaymentStatusPill({required this.status, Key? key}) : super(key: key);

  String getStatusText() {
    switch (status) {
      case 1:
        return "Not Paid";
      case 2:
        return "Pending";
      case 3:
        return "Paid";
      default:
        return "Expired";
    }
  }

  Color getStatusBackground() {
    switch (status) {
      case 1:
        return ColorConstant.notPaidStatus;
      case 2:
        return ColorConstant.pendingStatus;
      case 3:
        return ColorConstant.paidStatus;
      default:
        return ColorConstant.expiredStatus;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getStatusBackground(),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      width: 90,
      height: 34,
      child: Text(getStatusText(),
          style: TextStyle(color: Colors.white).merge(TypographyConstant.button1)),
    );
  }
}
