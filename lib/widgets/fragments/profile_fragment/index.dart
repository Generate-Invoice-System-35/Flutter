import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/components/login_fragment.dart';
import 'package:provider/provider.dart';

class ProfileFragment extends StatefulWidget {
  final int idx;
  const ProfileFragment(this.idx, {Key? key}) : super(key: key);

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {
  @override
  Widget build(BuildContext context) {
    String? token = context.watch<AuthViewModel>().token.data;
    if (token == null) {
      return LoginFragment();
    }
    return Container();
  }
}
