import 'package:flutter/material.dart';

class FormManager with ChangeNotifier {
  final _fieldStates = <String, FormFieldState>{};

  List<FormFieldState> get erroredFields => _fieldStates.entries
      .where((s) => (s.value.errorMessage ?? "").isNotEmpty)
      .map((s) => s.value)
      .toList();

  void setValue(String key, String? newValue) {
    _ensureExists(key);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_fieldStates[key]?.value != newValue) {
        _fieldStates[key]?.value = newValue;
        notifyListeners();
      }
    });
  }

  String? getErrorMessage(String key) {
    _ensureExists(key);
    return _fieldStates[key]?.errorMessage;
  }

  void setErrorMessage(String key, String? value) {
    _ensureExists(key);
    _fieldStates[key]?.errorMessage = value;
  }

  String? getValue(String key) {
    _ensureExists(key);
    return _fieldStates[key]?.value;
  }

  void _ensureExists(String key) {
    _fieldStates[key] ??= FormFieldState(key: key);
  }
}

class FormFieldState {
  final String key;

  String? errorMessage;
  String? value;

  FormFieldState({required this.key});
}
