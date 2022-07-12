import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/helpers/providers/overlay_manager.dart';
import 'package:flutter_capstone_project/model/common_model.dart';
import 'package:flutter_capstone_project/model/generate_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/generate_file_view_model.dart';
import 'package:flutter_capstone_project/view_models/generate_invoices_view_model.dart';
import 'package:flutter_capstone_project/view_models/invoice_view_model.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_circular_indicator.dart';
import 'package:flutter_capstone_project/widgets/invoice_items_table.dart';
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

class _InvoiceItemsFragmentState extends State<InvoiceItemsFragment> with TickerProviderStateMixin {
  late List<int> ids;
  int currentIdx = 0;
  late AnimationController _animationController;

  Future<void> refetchInvoice() async {
    await Provider.of<InvoiceViewModel>(context, listen: false)
        .getInvoice(invoiceId: ids[currentIdx]);
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat(max: 1);
    // _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      ids = Provider.of<FragmentManager>(context, listen: false).invoiceIds;
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await refetchInvoice();
      setState(() {});
    });

    super.didChangeDependencies();
  }

  void handleConfirm(BuildContext ctx) async {
    if (ctx.read<GenerateInvoicesViewModel>().invoices.status == ApiStatus.loading) return;
    ApiResponse<MessageResult> res =
        await Provider.of<GenerateInvoicesViewModel>(ctx, listen: false)
            .generateInvoices(input: GenerateInvoicesInput(ids: ids));
    if (res.status == ApiStatus.success) {
      Provider.of<OverlayManager>(ctx, listen: false)
          .switchOverlay(overlayEnum: OverlayEnum.emailSentOverlay);
      await Future.delayed(Duration(seconds: 1));
      Provider.of<OverlayManager>(ctx, listen: false).switchOverlay(overlayEnum: OverlayEnum.none);
    } else {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(SnackBar(content: Text(res.message ?? "Failed to sent")));
    }
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
              decoration: BoxDecoration(
                  color: ColorConstant.white, borderRadius: BorderRadius.circular(24)),
              child: context.read<InvoiceViewModel>().invoice?.status == ApiStatus.success
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Customer Invoice", style: TypographyConstant.h3),
                        const Text("Draft", style: TypographyConstant.title),
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
                        const SizedBox(height: 20),
                        const Text("Invoice Lines", style: TypographyConstant.invoiceLines),
                        InvoiceItemsTable(
                            tableHeight: MediaQuery.of(context).size.height - 520,
                            number: context.read<InvoiceViewModel>().invoice?.data?.number ?? ""),
                      ],
                    )
                  : Center(
                      child: RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                        child: GradientCircularProgressIndicator(
                          radius: MediaQuery.of(context).size.width / 10.5,
                          gradientColors: [
                            ColorConstant.white,
                            ColorConstant.orangeSolid,
                          ],
                          strokeWidth: 5.0,
                        ),
                      ),
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
                  loading: context.watch<GenerateInvoicesViewModel>().invoices.status ==
                      ApiStatus.loading,
                  onTap: () => handleConfirm(context),
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
