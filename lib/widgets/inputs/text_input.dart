import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class TextInput extends StatefulWidget {
  String label;
  String name;
  String? placeholder;
  IconData? prefixIcon;
  IconData? suffixIcon;
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
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onValidate != null) {
      context.read<FormManager>().setErrorMessage(
          widget.name, widget.onValidate!(context.read<FormManager>().getValue(widget.name)));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TypographyConstant.h2),
        Container(
          height: 29,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: context.read<FormManager>().getErrorMessage(widget.name) != null
                  ? Colors.red
                  : ColorConstant.inputBorder,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                  onChanged: (val) => _onChange(val, context),
                  style: TypographyConstant.input.merge(const TextStyle(height: 1.4)),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: TypographyConstant.input.merge(const TextStyle(height: 1)),
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
