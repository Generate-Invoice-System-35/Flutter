import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';

// ignore: must_be_immutable
class BorderlessInput extends StatefulWidget {
  String? placeholder;
  IconData? prefixIcon;
  Widget? suffixIcon;
  Widget? label;
  String? Function(String? val)? onValidate;
  void Function(TextEditingController tec)? onSuffixIconPress;

  BorderlessInput({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder,
    this.onValidate,
    this.onSuffixIconPress,
    this.label,
  }) : super(key: key);

  @override
  State<BorderlessInput> createState() => _BorderlessInputState();
}

class _BorderlessInputState extends State<BorderlessInput> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void _onChange(String? value, BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: ColorConstant.orangeSolid,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.label ?? const SizedBox.shrink(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // widget.prefixIcon != null
              //     ? Icon(widget.prefixIcon, size: 24)
              //     : const SizedBox.shrink(),
              // const SizedBox(
              //   width: 8,
              // ),
              Flexible(
                child: TextField(
                  controller: textEditingController,
                  onChanged: (val) => _onChange(val, context),
                  // style: TypographyConstant.input.merge(const TextStyle(height: 1.4)),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    // hintStyle: TypographyConstant.input.merge(const TextStyle(height: 1)),
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
                      icon: widget.suffixIcon!,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
