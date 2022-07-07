import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/generate_file_view_model.dart';
import 'package:flutter_capstone_project/widgets/common/file_upload_indicator.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class UploadFragment extends StatefulWidget {
  const UploadFragment({Key? key}) : super(key: key);

  @override
  State<UploadFragment> createState() => _UploadFragmentState();
}

class _UploadFragmentState extends State<UploadFragment> {
  String? fileName;
  double percent = 0;
  void handlePickFile(BuildContext context) async {
    FilePickerResult? filePickerRes = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'csv']);
    if (filePickerRes != null) {
      File file = File(filePickerRes.files.single.path!);
      String fileNameLocal = file.path.split('/')[file.path.split('/').length - 1];
      setState(() {
        fileName = fileNameLocal;
      });
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });
      final res = await Provider.of<GenerateFileViewModel>(context, listen: false).generateFile(
          formData: formData,
          onSendProgress: (start, end) {
            setState(() {
              percent = start / end;
            });
          });
      if (res.status != ApiStatus.success) {
        setState(() {
          fileName = null;
        });
      }
      if (res.message != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message!)));
      }
      print(res.data?.messages);
      print(res.message);
      print(res.data);
    }
    // print(res);
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
              onTap: () => handlePickFile(context),
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
            fileName != null
                ? FileUploadIndicator(
                    filename: fileName!,
                    percent: percent,
                  )
                : const SizedBox.shrink(),
          ],
        ));
  }
}
