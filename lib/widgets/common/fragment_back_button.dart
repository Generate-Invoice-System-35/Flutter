import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FragmentBackButton extends StatefulWidget {
  const FragmentBackButton({Key? key}) : super(key: key);

  @override
  State<FragmentBackButton> createState() => _FragmentBackButtonState();
}

class _FragmentBackButtonState extends State<FragmentBackButton> {
  void handlePop(BuildContext context) {
    context.read<FragmentManager>().pop();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<FragmentManager>().isEmpty()) {
      return const SizedBox.shrink();
    }
    return IconButton(
      onPressed: () => handlePop(context),
      icon: SvgPicture.asset('assets/icons/arrow-backward.svg'),
    );
  }
}
