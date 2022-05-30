import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/helpers/validators.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TextInput extends StatefulWidget {
  String label;
  String name;
  String? placeholder;
  IconData? prefixIcon;
  IconData? suffixIcon;
  bool obscureText;
  String? Function(String? val)? onValidate;
  void Function(TextEditingController tec)? onSuffixIconPress;

  TextInput({
    Key? key,
    required this.name,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder,
    this.onValidate,
    this.onSuffixIconPress,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void _onChange(String? value, BuildContext context) {
    context.read<FormManager>().setValue(widget.name, value);
    if (widget.onValidate != null) {
      context.read<FormManager>().setErrorMessage(widget.name, widget.onValidate!(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: context.read<FormManager>().getErrorMessage(widget.name) != null
                    ? Colors.red
                    : Colors.blue,
              ),
            ),
            // color: Colors.red,
          ),
          child: Row(
            children: [
              widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, size: 24)
                  : const SizedBox.shrink(),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: TextField(
                  controller: textEditingController,
                  obscureText: widget.obscureText,
                  onChanged: (val) => _onChange(val, context),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    border: InputBorder.none,
                    errorStyle: const TextStyle(height: 0, color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              widget.suffixIcon != null
                  ? IconButton(
                      onPressed: widget.onSuffixIconPress == null
                          ? null
                          : () => widget.onSuffixIconPress!(textEditingController),
                      icon: Icon(widget.suffixIcon, size: 24),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        context.read<FormManager>().getErrorMessage(widget.name) != null
            ? Text(context.read<FormManager>().getErrorMessage(widget.name)!,
                style: const TextStyle(color: Colors.redAccent))
            : const SizedBox.shrink()
      ],
    );
  }
}
