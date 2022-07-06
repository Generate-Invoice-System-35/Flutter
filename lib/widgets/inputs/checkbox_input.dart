import 'package:flutter/material.dart';

class CheckboxInput extends StatelessWidget {
  bool isChecked;
  void Function(bool? value) onChanged;
  CheckboxInput({required this.isChecked, required this.onChanged, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: onChanged,
    );
  }
}
