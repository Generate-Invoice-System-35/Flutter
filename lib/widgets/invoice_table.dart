import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/invoices_view_model.dart';
import 'package:flutter_capstone_project/widgets/common/payment_status_pill.dart';
import 'package:flutter_capstone_project/widgets/inputs/checkbox_input.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InvoiceTable extends StatefulWidget {
  final double tableHeight;
  String? query;
  Map<int, bool> checks;
  int curPage;
  void Function(int idx, bool state) changeChecksOnIdx;
  void Function(void Function()) changeState;
  InvoiceTable(
      {Key? key,
      required this.tableHeight,
      required this.query,
      required this.checks,
      required this.changeChecksOnIdx,
      required this.changeState,
      required this.curPage})
      : super(key: key);

  @override
  State<InvoiceTable> createState() => _InvoiceTableState();
}

class _InvoiceTableState extends State<InvoiceTable> {
  late Map<int, bool> checks;
  @override
  void initState() {
    checks = widget.checks;
    super.initState();
  }

  bool getAllChecked() {
    if (checks.containsValue(false) || checks.isEmpty) return false;
    return true;
  }

  void setAllChecked() {
    if (getAllChecked()) {
      for (int i = 0; i < checks.length; i++) {
        widget.changeChecksOnIdx(i, false);
      }
    } else {
      for (int i = 0; i < checks.length; i++) {
        widget.changeChecksOnIdx(i, true);
      }
    }
    widget.changeState(() {});
  }

  void getInvoices() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ApiResponse<List<Invoice>> res = await Provider.of<InvoicesViewModel>(context, listen: false)
          .getInvoicesByPage(input: InvoiceByPageInput(page: widget.curPage));
      if (Provider.of<InvoicesViewModel>(context, listen: false).invoices?.status ==
          ApiStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                Provider.of<InvoicesViewModel>(context, listen: false).invoices?.message ?? "")));
      }

      if (res.status == ApiStatus.success) {
        for (int i = 0; i < (res.data?.length ?? 0); i++) {
          widget.changeChecksOnIdx(i, false);
        }
        widget.changeState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    getInvoices();
    super.didChangeDependencies();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inDays / 24).round();
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    if (checks[index] == null) {
      widget.changeChecksOnIdx(index, false);
    }
    return Container(
      height: 52,
      width: 50,
      alignment: Alignment.center,
      child: CheckboxInput(
          isChecked: checks[index]!,
          onChanged: (val) {
            checks[index] = !checks[index]!;
            widget.changeState(() {});
          }),
    );
  }

  List<Invoice>? getFilteredData(ApiResponse<List<Invoice>>? data) {
    return data?.data?.where(
      (element) {
        return element.name?.contains(widget.query ?? "") ?? false;
      },
    ).toList();
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    ApiResponse<List<Invoice>>? data =
        Provider.of<InvoicesViewModel>(context, listen: false).invoices;
    List<Invoice>? invoices = getFilteredData(data);
    if (invoices != null && data?.status == ApiStatus.success) {
      return Row(
        children: <Widget>[
          Container(
            width: 70,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].number}', style: TypographyConstant.button1),
          ),
          Container(
            width: 150,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].name}', style: TypographyConstant.button1),
          ),
          Container(
            width: 100,
            height: 52,
            alignment: Alignment.center,
            child: Text(DateFormat('dd/MM/yyyy').format(invoices[index].invoiceDate!),
                style: TypographyConstant.button1),
          ),
          Container(
            width: 100,
            height: 52,
            alignment: Alignment.center,
            child: Text(DateFormat('dd/MM/yyyy').format(invoices[index].dueDate!),
                style: TypographyConstant.button1),
            // child: Text('${daysBetween(invoices![index].dueDate!, DateTime.now())} days'),
          ),
          Container(
            width: 150,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].email}', style: TypographyConstant.button1),
          ),
          Container(
            width: 120,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].phoneNumber}', style: TypographyConstant.button1),
          ),
          Container(
            width: 150,
            height: 52,
            alignment: Alignment.center,
            child: PaymentStatusPill(status: invoices[index].idPaymentStatus!),
            // child: Text('${daysBetween(data.data![index].dueDate!, DateTime.now())} days'),
          ),
        ],
      );
    }
    return Row(
      children: const [],
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      SizedBox(
        height: 60,
        child: CheckboxInput(isChecked: getAllChecked(), onChanged: (val) => setAllChecked()),
      ),
      _getTitleItemWidget('Number', 70),
      _getTitleItemWidget('Customer', 150),
      _getTitleItemWidget('Invoice Date', 100),
      _getTitleItemWidget('Due Date', 100),
      _getTitleItemWidget('Email', 150),
      _getTitleItemWidget('Phone Number', 120),
      _getTitleItemWidget('Payment Status', 150),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 60,
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.0),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.tableHeight,
      child: HorizontalDataTable(
        tableHeight: widget.tableHeight,
        leftHandSideColumnWidth: 50,
        isFixedHeader: true,
        rightHandSideColumnWidth: 840,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: (ctx, idx) => _generateFirstColumnRow(ctx, idx),
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: getFilteredData(context.read<InvoicesViewModel>().invoices)?.length ?? 0,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 0.0,
          thickness: 0.0,
        ),
      ),
    );
  }
}
