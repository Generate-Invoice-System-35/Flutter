// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/form_helper.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/helpers/validators.dart';
import 'package:flutter_capstone_project/model/auth_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/shadow.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/view_models/token_view_model.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:flutter_capstone_project/widgets/inputs/password_input.dart';
import 'package:flutter_capstone_project/widgets/inputs/text_input.dart';
import 'package:provider/provider.dart';

class RegisterFragment extends StatefulWidget {
  const RegisterFragment({Key? key}) : super(key: key);

  @override
  State<RegisterFragment> createState() => _RegisterFragmentState();
}

class _RegisterFragmentState extends State<RegisterFragment> {
  final FormManager _formManager = FormManager();

  void onSubmit(BuildContext context) async {
    if (_formManager.erroredFields.isEmpty) {
      final RegisterInput input = RegisterInput(
        username: _formManager.getValue('username'),
        password: _formManager.getValue('password'),
        address: _formManager.getValue("address"),
        email: _formManager.getValue('email'),
        name: _formManager.getValue('name'),
        phoneNumber: _formManager.getValue('phoneNumber'),
      );
      final res = await Provider.of<AuthViewModel>(context, listen: false).register(input: input);
      if (res.status == ApiStatus.success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Register Success")));
        Provider.of<FragmentManager>(context, listen: false).pop();
        Provider.of<FragmentManager>(context, listen: false)
            .navigateToFragment(fragmentEnum: FragmentEnum.loginFragment);
      } else {
        if (res.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message!)));
        }
      }
    }
  }

  String? onValidateUsername(String? value) {
    return Validators.required(value);
  }

  String? onValidatePassword(String? value) {
    if (value != _formManager.getValue('repeatPassword')) return "Password tidak sama";

    return Validators.required(value);
  }

  String? onValidateRepeatPassword(String? value) {
    if (value != _formManager.getValue('password')) return "Password tidak sama";

    return Validators.required(value);
  }

  String? onValidateEmail(String? value) {
    return Validators.required(value) ?? Validators.email(value);
  }

  String? onValidatePhoneNumber(String? value) {
    return Validators.required(value) ?? Validators.phoneNumber(value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const FragmentBackButton(),
              const SizedBox(height: 20),
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
                          placeholder: "Name",
                          label: "Name",
                          name: "name",
                          onValidate: onValidateUsername,
                        ),
                        const SizedBox(height: 8),
                        TextInput(
                          placeholder: "Username",
                          label: "Username",
                          name: "username",
                          onValidate: onValidateUsername,
                        ),
                        const SizedBox(height: 8),
                        PasswordInput(
                          name: "password",
                          label: "Password",
                          placeholder: "******",
                          onValidate: onValidatePassword,
                        ),
                        const SizedBox(height: 8),
                        PasswordInput(
                          name: "repeatPassword",
                          label: "Re-Password",
                          placeholder: "******",
                          onValidate: onValidateRepeatPassword,
                        ),
                        const SizedBox(height: 8),
                        TextInput(
                          placeholder: "Email",
                          label: "Email",
                          name: "email",
                          onValidate: onValidateEmail,
                        ),
                        const SizedBox(height: 8),
                        TextInput(
                          placeholder: "No. Hp",
                          label: "No. Hp",
                          name: "phoneNumber",
                          onValidate: onValidatePhoneNumber,
                        ),
                        const SizedBox(height: 8),
                        TextInput(
                          placeholder: "Alamat",
                          label: "Alamat",
                          name: "address",
                          onValidate: onValidateUsername,
                        ),
                        const SizedBox(height: 18),
                        GradientButton(
                          "START",
                          loading: context.watch<AuthViewModel>().token.status == ApiStatus.loading,
                          width: double.infinity,
                          height: 40,
                          gradient: ColorConstant.orangeGradient,
                          onTap: () => onSubmit(context),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [ShadowConstant.boxShadow1],
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          textStyle: TypographyConstant.button2
                              .merge(TextStyle(color: ColorConstant.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
