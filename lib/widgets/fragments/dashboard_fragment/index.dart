import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/widgets/fragments/dashboard_fragment/components/invoice_items_fragment.dart';
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
      return const LoginFragment();
    }
    switch (fragmentEnum) {
      case FragmentEnum.uploadFragment:
        return const UploadFragment();
      case FragmentEnum.sendInvoicesFragment:
        return const SendInvoicesFragment();
      case FragmentEnum.invoiceItemsFragment:
        return const InvoiceItemsFragment();
      default:
        return const InvoicesFragment();
    }
  }
}
