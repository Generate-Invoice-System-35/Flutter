import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/components/invoices_fragment.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/components/upload_fragment.dart';
import 'package:provider/provider.dart';

class DashboardFragment extends StatefulWidget {
  final int idx;
  const DashboardFragment(this.idx, {Key? key}) : super(key: key);

  @override
  State<DashboardFragment> createState() => _DashboardFragmentState();
}

class _DashboardFragmentState extends State<DashboardFragment> {
  @override
  Widget build(BuildContext context) {
    FragmentEnum? fragmentEnum = context.watch<FragmentManager>().top();
    switch (fragmentEnum) {
      case FragmentEnum.uploadFragment:
        return UploadFragment();
      default:
        return InvoicesFragment();
    }
  }
}
