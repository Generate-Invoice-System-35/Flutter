import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/form_helper.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/shadow.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_capstone_project/widgets/inputs/password_input.dart';
import 'package:flutter_capstone_project/widgets/inputs/text_input.dart';

class LoginFragment extends StatefulWidget {
  const LoginFragment({Key? key}) : super(key: key);

  @override
  State<LoginFragment> createState() => _LoginFragmentState();
}

class _LoginFragmentState extends State<LoginFragment> {
  final FormManager _formManager = FormManager();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const FragmentBackButton(),
            const SizedBox(height: 47),
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 36),
                decoration: BoxDecoration(
                    color: ColorConstant.white,
                    boxShadow: [ShadowConstant.boxShadow1],
                    borderRadius: BorderRadius.circular(24)),
                child: FormHelper(
                  formManager: _formManager,
                  builder: (state) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Image(
                        image: AssetImage(
                          "assets/images/logo.png",
                        ),
                        height: 35,
                        width: 86,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        color: ColorConstant.redLight,
                        child: const Text(
                          "Access and manage your instance from this Fattures account.",
                          style: TypographyConstant.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Divider(
                        color: ColorConstant.divider1,
                        thickness: 1,
                      ),
                      const SizedBox(height: 12),
                      TextInput(
                        placeholder: "Username",
                        label: "Username",
                        name: "username",
                      ),
                      const SizedBox(height: 20),
                      PasswordInput(
                        name: "password",
                        label: "Password",
                        placeholder: "******",
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                              gradient: ColorConstant.orangeGradient,
                              borderRadius: const BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'SIGN IN',
                            textAlign: TextAlign.center,
                            style: TypographyConstant.button2
                                .merge(const TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
