import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/utils/shadow.constant.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class TableComponent extends StatefulWidget {
  final double tableHeight;
  const TableComponent({Key? key, required this.tableHeight}) : super(key: key);

  @override
  State<TableComponent> createState() => _TableComponentState();
}

class _TableComponentState extends State<TableComponent> {
  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text("123"),
      height: 52,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.notifications_active, color: Colors.red),
              Text('Active'),
            ],
          ),
          width: 100,
          height: 52,
          alignment: Alignment.center,
        ),
        Container(
          child: Text("01234"),
          width: 200,
          height: 52,
          alignment: Alignment.center,
        ),
        Container(
          child: Text("Register date-1"),
          width: 100,
          height: 52,
          alignment: Alignment.center,
        ),
        Container(
          child: Text("Termination Date-1"),
          width: 100,
          height: 52,
          alignment: Alignment.center,
        ),
      ],
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      GestureDetector(
        child: _getTitleItemWidget('Name', 100),
        onTap: () => {print("header 1 1click")},
      ),
      _getTitleItemWidget('Status', 100),
      _getTitleItemWidget('Phone', 200),
      _getTitleItemWidget('Register', 100),
      _getTitleItemWidget('Termination', 100),
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
        leftHandSideColumnWidth: 100,
        isFixedHeader: true,
        rightHandSideColumnWidth: 500,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: (ctx, idx) => _generateFirstColumnRow(ctx, idx),
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: 10,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 0.0,
          thickness: 0.0,
        ),
      ),
    );
  }
}
