import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/invoice_view_model.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LabelValue extends StatelessWidget {
  final String label;
  final String value;
  const LabelValue({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: TypographyConstant.h4),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: ColorConstant.borderBottomProfile,
            ))),
            child: Text(value, maxLines: 1),
          ),
        )
      ],
    );
  }
}

class InvoiceItemsFragment extends StatefulWidget {
  const InvoiceItemsFragment({Key? key}) : super(key: key);

  @override
  State<InvoiceItemsFragment> createState() => _InvoiceItemsFragmentState();
}

class _InvoiceItemsFragmentState extends State<InvoiceItemsFragment> {
  late List<int> ids;
  int currentIdx = 0;

  Future<void> refetchInvoice() async {
    await Provider.of<InvoiceViewModel>(context, listen: false)
        .getInvoice(invoiceId: ids[currentIdx]);
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      ids = Provider.of<FragmentManager>(context, listen: false).invoiceIds;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      refetchInvoice();
      // setState(() {});
    });

    super.didChangeDependencies();
  }

  void onDoubleBackward() async {
    setState(() {
      currentIdx = 0;
    });
    await refetchInvoice();
    setState(() {});
  }

  void onDoubleForward() async {
    setState(() {
      currentIdx = ids.length - 1;
    });
    await refetchInvoice();
    setState(() {});
  }

  void onBackward() async {
    setState(() {
      currentIdx = max(0, currentIdx - 1);
    });
    await refetchInvoice();
    setState(() {});
  }

  void onForward() async {
    setState(() {
      currentIdx = min(ids.length - 1, currentIdx + 1);
    });
    await refetchInvoice();
    setState(() {});
  }

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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 40),
              decoration: BoxDecoration(
                  color: ColorConstant.white, borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Customer Invoice", style: TypographyConstant.h3),
                  Text("Draft", style: TypographyConstant.title),
                  const SizedBox(height: 32),
                  LabelValue(
                      label: "Customer",
                      value: context.read<InvoiceViewModel>().invoice?.data?.name ?? ""),
                  const SizedBox(height: 5),
                  LabelValue(
                      label: "Invoice Date",
                      value: DateFormat('dd/MM/yyyy').format(
                          context.read<InvoiceViewModel>().invoice?.data?.invoiceDate ??
                              DateTime.now())),
                  const SizedBox(height: 5),
                  LabelValue(
                      label: "Due Date",
                      value: DateFormat('dd/MM/yyyy').format(
                          context.read<InvoiceViewModel>().invoice?.data?.dueDate ??
                              DateTime.now())),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                GradientButton(
                  "Confirm",
                  gradient: ColorConstant.orangeGradient,
                  onTap: () => {},
                  padding: const EdgeInsets.fromLTRB(17, 9, 18, 10),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  height: 40,
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 150),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        GestureDetector(
                          onTap: onDoubleBackward,
                          child: SvgPicture.asset('assets/icons/double-backward.svg'),
                        ),
                        GestureDetector(
                          onTap: onBackward,
                          child: SvgPicture.asset('assets/icons/backward.svg'),
                        ),
                        Text('${currentIdx + 1}/${ids.length}',
                            style: TextStyle(
                              color: ColorConstant.notPaidStatus,
                            ).merge(TypographyConstant.h2)),
                        GestureDetector(
                          onTap: onForward,
                          child: SvgPicture.asset('assets/icons/forward.svg'),
                        ),
                        GestureDetector(
                          onTap: onDoubleForward,
                          child: SvgPicture.asset('assets/icons/double-forward.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
