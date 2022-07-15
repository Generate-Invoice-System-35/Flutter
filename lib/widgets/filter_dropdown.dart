import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/invoices_view_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class FilterDropdown extends StatefulWidget {
  void Function(void Function()) changeState;
  void Function(int idx, bool state) changeChecksOnIdx;
  void Function() clearChecks;
  int page;

  FilterDropdown(
      {Key? key,
      required this.changeState,
      required this.changeChecksOnIdx,
      required this.clearChecks,
      required this.page})
      : super(key: key);

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown> {
  String? selectedValue;
  final List<String> items = [
    'Unpaid',
    'Paid',
    'Pending',
    'Expired',
  ];

  Future<void> getInvoices() async {
    await Provider.of<InvoicesViewModel>(context, listen: false)
        .getInvoicesByPage(input: InvoiceByPageInput(page: widget.page));
  }

  Future<void> getInvoicesByStatus({required int status}) async {
    await Provider.of<InvoicesViewModel>(context, listen: false)
        .getInvoicesByStatus(status: status, input: InvoiceByPageInput(page: widget.page));
  }

  void handleChange(String? value, BuildContext context) async {
    if (value == selectedValue) {
      await getInvoices();
      widget.changeState(() {});

      return setState(() {
        selectedValue = null;
      });
    }
    switch (value) {
      case "Unpaid":
        await getInvoicesByStatus(status: 1);
        break;
      case "Paid":
        await getInvoicesByStatus(status: 2);
        break;
      case "Pending":
        await getInvoicesByStatus(status: 3);
        break;
      case "Expired":
        await getInvoicesByStatus(status: 4);
        break;
    }

    ApiResponse<List<Invoice>>? res =
        Provider.of<InvoicesViewModel>(context, listen: false).invoices;
    widget.clearChecks();
    if (res?.status == ApiStatus.success) {
      for (int i = 0; i < (res?.data?.length ?? 0); i++) {
        widget.changeChecksOnIdx(i, false);
      }
    }
    setState(() {
      selectedValue = value;
    });
    widget.changeState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: Row(
        children: [
          SvgPicture.asset('assets/icons/filter.svg'),
          const SizedBox(width: 10),
          Text(
            selectedValue ?? 'Filters',
            style: TypographyConstant.button3.merge(const TextStyle(color: Colors.black)),
          ),
        ],
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              Text(item),
              item == selectedValue
                  ? const SizedBox(
                      width: 8,
                    )
                  : const SizedBox.shrink(),
              item == selectedValue
                  ? const Icon(Icons.close_outlined, size: 20, color: Colors.red)
                  : const SizedBox.shrink()
            ],
          ),
        );
      }).toList(),
      onChanged: (value) => handleChange(value as String, context),
      iconSize: 0,
      underline: const SizedBox.shrink(),
    );
  }
}
