import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/invoice_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/view_models/invoices_view_model.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TableComponent extends StatefulWidget {
  final double tableHeight;
  const TableComponent({Key? key, required this.tableHeight}) : super(key: key);

  @override
  State<TableComponent> createState() => _TableComponentState();
}

class _TableComponentState extends State<TableComponent> {
  void getInvoices() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<InvoicesViewModel>(context, listen: false).getInvoices();
      if (Provider.of<InvoicesViewModel>(context, listen: false).invoices?.status ==
          ApiStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                Provider.of<InvoicesViewModel>(context, listen: false).invoices?.message ?? "")));
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
    return (to.difference(from).inHours / 24).round();
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text("123"),
      height: 52,
      width: 50,
      alignment: Alignment.center,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    ApiResponse<List<Invoice>>? data =
        Provider.of<InvoicesViewModel>(context, listen: false).invoices;
    if (data != null && data.status == ApiStatus.success) {
      return Row(
        children: <Widget>[
          Container(
            width: 70,
            height: 52,
            alignment: Alignment.center,
            child: Text('${data.data![index].number}'),
          ),
          Container(
            width: 150,
            height: 52,
            alignment: Alignment.center,
            child: Text('${data.data![index].buyerName}'),
          ),
          Container(
            width: 100,
            height: 52,
            alignment: Alignment.center,
            child: Text(DateFormat('dd/MM/yyyy').format(data.data![index].invoiceDate!)),
          ),
          Container(
            width: 100,
            height: 52,
            alignment: Alignment.center,
            child: Text('${daysBetween(data.data![index].dueDate!, DateTime.now())} days'),
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
      GestureDetector(
        child: _getTitleItemWidget('Name', 50),
        onTap: () => {print("header 1 1click")},
      ),
      _getTitleItemWidget('Number', 70),
      _getTitleItemWidget('Customer', 150),
      _getTitleItemWidget('Invoice Date', 100),
      _getTitleItemWidget('Due Date', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 60,
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      color: Colors.black.withOpacity(0.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   ShadowConstant.boxShadow1,
        // ],
        color: Colors.red,
      ),
      width: double.infinity,
      height: widget.tableHeight,
      child: HorizontalDataTable(
        tableHeight: widget.tableHeight,
        leftHandSideColumnWidth: 50,
        isFixedHeader: true,
        rightHandSideColumnWidth: 500,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: (ctx, idx) => _generateFirstColumnRow(ctx, idx),
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: context.read<InvoicesViewModel>().invoices?.data?.length ?? 0,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 0.0,
          thickness: 0.0,
        ),
      ),
    );
  }
}
