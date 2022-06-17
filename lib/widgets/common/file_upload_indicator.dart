import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FileUploadIndicator extends StatefulWidget {
  final String filename;
  const FileUploadIndicator({Key? key, required this.filename}) : super(key: key);

  @override
  State<FileUploadIndicator> createState() => _FileUploadIndicatorState();
}

class _FileUploadIndicatorState extends State<FileUploadIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            Image.asset(
              'assets/images/file-outlined.png',
              width: 14,
              height: 18,
            ),
            const SizedBox(width: 10),
            Text(widget.filename, style: TypographyConstant.body),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: LinearPercentIndicator(
                alignment: MainAxisAlignment.start,
                lineHeight: 14.0,
                percent: 0.5,
                backgroundColor: ColorConstant.backgroundIndicator,
                progressColor: ColorConstant.orangeLight,
                padding: EdgeInsets.zero,
                barRadius: const Radius.circular(40),
              ),
            ),
            const SizedBox(width: 11),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstant.white,
                  ),
                  onPressed: () {},
                  child: Text("Cancel",
                      style:
                          TypographyConstant.button1.merge(const TextStyle(color: Colors.black)))),
            )
          ],
        )
      ]),
    );
  }
}
