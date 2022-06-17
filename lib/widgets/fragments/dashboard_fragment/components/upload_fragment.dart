import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/file_upload_indicator.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_svg/svg.dart';

class UploadFragment extends StatefulWidget {
  const UploadFragment({Key? key}) : super(key: key);

  @override
  State<UploadFragment> createState() => _UploadFragmentState();
}

class _UploadFragmentState extends State<UploadFragment> {
  void handlePickFile() async {
    FilePickerResult? res = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'csv']);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: FragmentBackButton(),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: handlePickFile,
              child: DottedBorder(
                color: ColorConstant.orangeSolid,
                strokeWidth: 1,
                dashPattern: const [16],
                radius: const Radius.circular(24),
                borderType: BorderType.RRect,
                child: Container(
                  width: double.infinity,
                  height: 383,
                  decoration: BoxDecoration(
                    color: ColorConstant.uploadContainerBg,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/upload.svg'),
                      const SizedBox(height: 36),
                      Text(
                        "Select a file to upload",
                        style: TypographyConstant.bigTitle.merge(
                          TextStyle(color: ColorConstant.orangeSolid),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Text("or drag and drop it here",
                      //     style: TypographyConstant.button1
                      //         .merge(TextStyle(color: ColorConstant.darkBlue)))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 36),
            const FileUploadIndicator(
              filename: "customerdata.xls",
            ),
            const SizedBox(height: 20),
            const FileUploadIndicator(
              filename: "customerdata.xls",
            ),
          ],
        ));
  }
}
