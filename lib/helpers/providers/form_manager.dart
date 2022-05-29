import 'package:flutter/material.dart';

class FormManager with ChangeNotifier {
  final _fieldStates = <String, FormFieldState>{};

  void setValueForField(String key, String? newValue) {
    _ensureExists(key);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_fieldStates[key]?.value != newValue) {
        _fieldStates[key]?.value = newValue;
        notifyListeners();
      }
    });
  }

  String? getErrorMessageForField(String key) {
    _ensureExists(key);
    return _fieldStates[key]?.errorMessage;
  }

  String? getValueForField(String key) {
    _ensureExists(key);
    return _fieldStates[key]?.value;
  }

  FormFieldValidator<T>? wrapValidator<T>(String key, FormFieldValidator<T>? validator) {
    if (validator == null) return null;
    _ensureExists(key);

    return (input) {
      final result = validator(input);
      _fieldStates[key]?.errorMessage = result;

      return result;
    };
  }

  List<FormFieldState> get erroredFields =>
      _fieldStates.entries.where((s) => s.value.errorMessage != null).map((s) => s.value).toList();

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
