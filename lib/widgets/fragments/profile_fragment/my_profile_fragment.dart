import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/form_helper.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/helpers/providers/overlay_manager.dart';
import 'package:flutter_capstone_project/helpers/validators.dart';
import 'package:flutter_capstone_project/model/auth_model.dart';
import 'package:flutter_capstone_project/model/user_model.dart';
import 'package:flutter_capstone_project/services/services.dart';
import 'package:flutter_capstone_project/utils/color.constant.dart';
import 'package:flutter_capstone_project/utils/shadow.constant.dart';
import 'package:flutter_capstone_project/utils/typography.constant.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/view_models/token_view_model.dart';
import 'package:flutter_capstone_project/view_models/user_view_model.dart';
import 'package:flutter_capstone_project/widgets/common/fragment_back_button.dart';
import 'package:flutter_capstone_project/widgets/common/gradient_button.dart';
import 'package:flutter_capstone_project/widgets/inputs/text_input.dart';
import 'package:provider/provider.dart';

class MyProfileFragment extends StatefulWidget {
  const MyProfileFragment({Key? key}) : super(key: key);

  @override
  State<MyProfileFragment> createState() => _MyProfileFragmentState();
}

class _MyProfileFragmentState extends State<MyProfileFragment> {
  final FormManager _formManager = FormManager();

  String? onValidateUsername(String? value) {
    return Validators.required(value);
  }

  String? onValidatePassword(String? value) {
    return Validators.required(value);
  }

  void onSubmit(BuildContext context) async {
    if (Provider.of<UserViewModel>(context, listen: false).user.status == ApiStatus.loading) return;

    if (_formManager.erroredFields.isEmpty) {
      final UpdateUsernameInput input =
          UpdateUsernameInput(username: _formManager.getValue('username'));

      final id = Provider.of<UserViewModel>(context, listen: false).user.data?.id;
      if (id != null) {
        final res = await Provider.of<UserViewModel>(context, listen: false)
            .updateUsername(id: id, input: input);
        if (res.status == ApiStatus.error) {
          if (res.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res.message!)));
          }
        } else if (res.status == ApiStatus.success) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${res.data?.messages!}')));
          context
              .read<OverlayManager>()
              .switchOverlay(overlayEnum: OverlayEnum.profileUpdatedOverlay);
        }
      }
    }
  }

  void getMe() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String? token = Provider.of<AuthViewModel>(context, listen: false).token.data;
      if (token != null) {
        String? resUsername = (await Provider.of<UserViewModel>(context, listen: false)
                .getMe(input: UserByTokenInput(token: token)))
            .data
            ?.email;
        if (resUsername != null) {
          _formManager.setValue('username', resUsername);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    getMe();
    super.didChangeDependencies();
  }

  void onNavigateChangePassword(BuildContext context) {
    context
        .read<FragmentManager>()
        .navigateToFragment(fragmentEnum: FragmentEnum.changePasswordFragment);
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
              SizedBox(height: MediaQuery.of(context).size.height / 6),
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
                          defaultValue: context.read<UserViewModel>().user.data?.email,
                          onValidate: onValidateUsername,
                        ),
                        const SizedBox(height: 23),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Password Management",
                            style: TypographyConstant.h2,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: ColorConstant.textButtonOrange,
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => onNavigateChangePassword(context),
                            child: Text("CHANGE PASSWORD",
                                style: TypographyConstant.h2
                                    .merge(const TextStyle(decoration: TextDecoration.underline))),
                          ),
                        ),
                        const SizedBox(height: 40),
                        GradientButton(
                          "EDIT",
                          width: double.infinity,
                          loading: (context.read<UserViewModel>().user.status == ApiStatus.loading),
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
