import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/model/invoice_item_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/invoice_items_by_number_view_model.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:provider/provider.dart';

class InvoiceItemsTable extends StatefulWidget {
  final double tableHeight;
  final String number;

  const InvoiceItemsTable({
    Key? key,
    required this.tableHeight,
    required this.number,
  }) : super(key: key);

  @override
  State<InvoiceItemsTable> createState() => _InvoiceItemsTableState();
}

class _InvoiceItemsTableState extends State<InvoiceItemsTable> {
  void getInvoices() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ApiResponse<List<InvoiceItem>> res =
          await Provider.of<InvoiceItemsByNumberViewModel>(context, listen: false)
              .getInvoiceItemsByNumber(number: widget.number);
      if (Provider.of<InvoiceItemsByNumberViewModel>(context, listen: false).invoiceItems?.status ==
          ApiStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(Provider.of<InvoiceItemsByNumberViewModel>(context, listen: false)
                    .invoiceItems
                    ?.message ??
                "")));
      }
    });
  }

  @override
  void didChangeDependencies() {
    getInvoices();
    super.didChangeDependencies();
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container();
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    ApiResponse<List<InvoiceItem>>? data =
        Provider.of<InvoiceItemsByNumberViewModel>(context, listen: false).invoiceItems;
    List<InvoiceItem>? invoices = data?.data;
    if (invoices != null && data?.status == ApiStatus.success) {
      return Row(
        children: <Widget>[
          Container(
            width: 200,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].product}', style: TypographyConstant.button1),
          ),
          Container(
            width: 70,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].qty}', style: TypographyConstant.button1),
          ),
          Container(
            width: 100,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].price}', style: TypographyConstant.button1),
          ),
          Container(
            width: 100,
            height: 52,
            alignment: Alignment.center,
            child: Text('${invoices[index].subtotal}', style: TypographyConstant.button1),
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
      _getTitleItemWidget('', 0),
      _getTitleItemWidget('Product', 200),
      _getTitleItemWidget('Quantity', 70),
      _getTitleItemWidget('Price', 100),
      _getTitleItemWidget('Subtotal', 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 40,
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
        leftHandSideColumnWidth: 0,
        isFixedHeader: true,
        rightHandSideColumnWidth: 470,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: (ctx, idx) => _generateFirstColumnRow(ctx, idx),
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: context.read<InvoiceItemsByNumberViewModel>().invoiceItems?.data?.length ?? 0,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 0.0,
          thickness: 0.0,
        ),
      ),
    );
  }
}
