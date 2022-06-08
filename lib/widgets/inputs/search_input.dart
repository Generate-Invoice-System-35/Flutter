import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchInput extends StatefulWidget {
  String? placeholder;
  IconData? prefixIcon;
  IconData? suffixIcon;
  String? Function(String? val)? onValidate;
  void Function(TextEditingController tec)? onSuffixIconPress;

  SearchInput({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.placeholder,
    this.onValidate,
    this.onSuffixIconPress,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void _onChange(String? value, BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: ColorConstant.orangeSolid,
              ),
            ),
          ),
          child: Row(
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
              // widget.suffixIcon != null
              //     ? IconButton(
              //         onPressed: widget.onSuffixIconPress == null
              //             ? null
              //             : () => widget.onSuffixIconPress!(textEditingController),
              //         icon: Icon(widget.suffixIcon, size: 24),
              //       )
              //     : const SizedBox.shrink(),
              SvgPicture.asset('assets/icons/search.svg'),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
