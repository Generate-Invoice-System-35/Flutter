import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:provider/provider.dart';

class FormHelper extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final FormManager formManager;
  final Widget Function(
    FormManager manager,
  ) builder;
  FormHelper({Key? key, required this.formManager, required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FormManager>(
      create: (_) => formManager,
      child: Consumer<FormManager>(
        builder: (_, __, ___) => Form(
          key: _formKey,
          child: builder(__),
        ),
      ),
    );
  }
}
