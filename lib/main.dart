import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/helpers/providers/overlay_manager.dart';
import 'package:flutter_capstone_project/helpers/validators.dart';
import 'package:flutter_capstone_project/screens/main_screen.dart';
import 'package:flutter_capstone_project/screens/splash_screen.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/view_models/generate_file_view_model.dart';
import 'package:flutter_capstone_project/view_models/generate_invoices_view_model.dart';
import 'package:flutter_capstone_project/view_models/invoice_items_by_number_view_model.dart';
import 'package:flutter_capstone_project/view_models/invoice_total_pagination_view_model.dart';
import 'package:flutter_capstone_project/view_models/invoice_view_model.dart';
import 'package:flutter_capstone_project/view_models/invoices_view_model.dart';
import 'package:flutter_capstone_project/view_models/token_view_model.dart';
import 'package:flutter_capstone_project/view_models/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyProvider());
}

class MyProvider extends StatelessWidget {
  const MyProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenViewModel()),
        ChangeNotifierProvider(create: (_) => GenerateFileViewModel()),
        ChangeNotifierProvider(create: (_) => GenerateInvoicesViewModel()),
        ChangeNotifierProvider(create: (_) => InvoiceTotalPaginationViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => InvoiceItemsByNumberViewModel()),
        ChangeNotifierProvider(create: (_) => InvoicesViewModel()),
        ChangeNotifierProvider(create: (_) => InvoiceViewModel()),
        ChangeNotifierProvider(create: (_) => FragmentManager()),
        ChangeNotifierProvider(create: (_) => OverlayManager()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget getInitialPage({required AsyncSnapshot<Object?> tokenSnapshot}) {
    if (tokenSnapshot.connectionState == ConnectionState.waiting) {
      return const SplashScreen();
    }
    if (tokenSnapshot.data != null) return const MainScreen();
    return const MainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TokenViewModel>(
      builder: (_, state, ___) => FutureBuilder(
        future: state.setupToken(context),
        builder: (_, tokenSnapshot) {
          return MaterialApp(
            theme: ThemeData(fontFamily: "Poppins"),
            debugShowCheckedModeBanner: false,
            routes: const {},
            home: getInitialPage(
              tokenSnapshot: tokenSnapshot,
            ),
          );
        },
      ),
    );
  }
}
