import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/view_models/token_view_model.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/components/invoices_fragment.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/components/send_invoices_fragment.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/components/upload_fragment.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/components/login_fragment.dart';
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
    String? token = context.watch<AuthViewModel>().token.data;
    if (token == null) {
      return LoginFragment();
    }
    switch (fragmentEnum) {
      case FragmentEnum.uploadFragment:
        return UploadFragment();
      case FragmentEnum.sendInvoicesFragment:
        return SendInvoicesFragment();
      default:
        return InvoicesFragment();
    }
  }
}
