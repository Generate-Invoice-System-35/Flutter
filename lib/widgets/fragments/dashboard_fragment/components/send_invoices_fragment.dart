import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_capstone_project/widgets/inputs/borderless_input.dart';

class SendInvoicesFragment extends StatefulWidget {
  const SendInvoicesFragment({Key? key}) : super(key: key);

  @override
  State<SendInvoicesFragment> createState() => _SendInvoicesFragmentState();
}

class _SendInvoicesFragmentState extends State<SendInvoicesFragment> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: FragmentBackButton(),
          ),
          const SizedBox(height: 25),
          const Text("Send Invoices", style: TypographyConstant.title),
          const SizedBox(height: 30),
          BorderlessInput(
              label: Text("Recipients", style: TypographyConstant.borderlessInputLabel)),
          const SizedBox(height: 30),
          BorderlessInput(label: Text("Subject", style: TypographyConstant.borderlessInputLabel))
        ],
      ),
    );
  }
}
