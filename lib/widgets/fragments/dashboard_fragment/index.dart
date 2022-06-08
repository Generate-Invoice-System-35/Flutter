import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/components/invoices_fragment.dart';

class DashboardFragment extends StatefulWidget {
  final int idx;
  const DashboardFragment(this.idx, {Key? key}) : super(key: key);

  @override
  State<DashboardFragment> createState() => _DashboardFragmentState();
}

class _DashboardFragmentState extends State<DashboardFragment> {
  @override
  Widget build(BuildContext context) {
    return InvoicesFragment();
  }
}
