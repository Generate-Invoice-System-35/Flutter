import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/helpers/providers/overlay_manager.dart';
import 'package:flutter_capstone_project/helpers/validators.dart';
import 'package:flutter_capstone_project/screens/main_screen.dart';
import 'package:flutter_capstone_project/screens/splash_screen.dart';
import 'package:flutter_capstone_project/view_models/auth_view_model.dart';
import 'package:flutter_capstone_project/view_models/generate_view_model.dart';
import 'package:flutter_capstone_project/view_models/invoice_view_model.dart';
import 'package:flutter_capstone_project/view_models/invoices_view_model.dart';
import 'package:flutter_capstone_project/view_models/token_view_model.dart';
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
        ChangeNotifierProvider(create: (_) => GenerateViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
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
  final FormManager _formManager = FormManager();

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
    switch (settings.name) {
      // case "/course-detail":
      //   final String id = (settings.arguments ?? "626e792c055c8bad64bc2131") as String;
      //   return PageRouteBuilder(
      //     settings: settings,
      //     pageBuilder: (_, __, ___) => CourseDetailScreen(id: id),
      //     transitionsBuilder: (_, animation, __, child) {
      //       final tween = Tween(begin: const Offset(1, 1), end: Offset.zero);
      //       return SlideTransition(
      //         position: animation.drive(tween),
      //         child: child,
      //       );
      //     },
      //   );
    }
    return null;
  }

  Widget getInitialPage({required AsyncSnapshot<Object?> tokenSnapshot}) {
    if (tokenSnapshot.connectionState == ConnectionState.waiting) {
      return const SplashScreen();
    }
    if (tokenSnapshot.data != null) return const MainScreen();
    return const MainScreen();
  }

  String? onValidateEmail(String? value) {
    return Validators.email(value) ?? Validators.required(value);
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(fontFamily: "Poppins"),
    //   home: MainScreen(),
    // );

    return Consumer<TokenViewModel>(
      builder: (_, state, ___) => FutureBuilder(
        future: state.setupToken(),
        builder: (_, tokenSnapshot) {
          return MaterialApp(
            theme: ThemeData(fontFamily: "Poppins"),
            debugShowCheckedModeBanner: false,
            routes: {},

            home: getInitialPage(
              tokenSnapshot: tokenSnapshot,
            ),
            // initialRoute: '/',
            onGenerateRoute: onGenerateRoute,
          );
        },
      ),
    );
  }
}
