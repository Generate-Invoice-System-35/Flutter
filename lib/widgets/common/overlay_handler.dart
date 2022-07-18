import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/overlay_manager.dart';
import 'package:flutter_capstone_project/widgets/common/overlay/email_sent_overlay.dart';
import 'package:flutter_capstone_project/widgets/common/overlay/loading_overlay.dart';
import 'package:flutter_capstone_project/widgets/common/overlay/profile_updated_overlay.dart';
import 'package:flutter_capstone_project/widgets/common/overlay/uploaded_overlay.dart';
import 'package:provider/provider.dart';

class OverlayHandler extends StatefulWidget {
  const OverlayHandler({Key? key}) : super(key: key);

  @override
  State<OverlayHandler> createState() => _OverlayHandlerState();
}

class _OverlayHandlerState extends State<OverlayHandler> {
  @override
  Widget build(BuildContext context) {
    switch (context.watch<OverlayManager>().currentOverlay) {
      case OverlayEnum.emailSentOverlay:
        return const EmailSentOverlay();
      case OverlayEnum.loadingOverlay:
        return const LoadingOverlay();
      case OverlayEnum.uploadedOverlay:
        return const UploadedOverlay();
      case OverlayEnum.profileUpdatedOverlay:
        return const ProfileUpdatedOverlay();
      default:
        return const SizedBox.shrink();
    }
  }
}
