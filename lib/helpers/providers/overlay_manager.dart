import 'package:flutter/material.dart';

enum OverlayEnum {
  loadingOverlay,
  emailSentOverlay,
  none,
}

class OverlayManager with ChangeNotifier {
  OverlayEnum _currentOverlay = OverlayEnum.none;

  OverlayEnum get currentOverlay => _currentOverlay;

  void navigateToFragment({required OverlayEnum overlayEnum}) {
    _currentOverlay = overlayEnum;
    notifyListeners();
  }
}
