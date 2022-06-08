import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/components/login_fragment.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/components/onboarding_fragment.dart';
import 'package:flutter_capstone_project/widgets/fragments/home_fragment/components/register_fragment.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  final int idx;
  const HomeFragment(this.idx, {Key? key}) : super(key: key);

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    FragmentEnum fragmentEnum = context
        .watch<FragmentManager>()
        .activeFragment[context.read<FragmentManager>().untrackedCurrentIdx];
    switch (fragmentEnum) {
      case FragmentEnum.loginFragment:
        return LoginFragment();
      case FragmentEnum.registerFragment:
        return RegisterFragment();
      default:
        return OnboardingFragment();
    }
  }
}
