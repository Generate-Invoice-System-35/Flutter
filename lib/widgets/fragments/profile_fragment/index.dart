import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/components/login_fragment.dart';
import 'package:flutter_capstone_project/widgets/fragments/profile_fragment/my_profile_fragment.dart';
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
    FragmentEnum? fragmentEnum = context.watch<FragmentManager>().top();

    String? token = context.watch<AuthViewModel>().token.data;
    if (token == null) {
      return LoginFragment();
    }
    switch (fragmentEnum) {
      default:
        return MyProfileFragment();
    }
  }
}
