import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/form_helper.dart';
import 'package:flutter_capstone_project/helpers/providers/form_manager.dart';
import 'package:flutter_capstone_project/helpers/validators.dart';
import 'package:flutter_capstone_project/screens/main_screen.dart';
import 'package:flutter_capstone_project/view_models/token_view_model.dart';
import 'package:flutter_capstone_project/widgets/bottom_navigator.dart';
import 'package:flutter_capstone_project/widgets/fragments/login_fragment.dart';
import 'package:flutter_capstone_project/widgets/inputs/text_input.dart';
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

  // Widget getInitialPage(
  //     {required AsyncSnapshot<Object?> tokenSnapshot,
  //     required AsyncSnapshot<Object?> userSnapshot}) {
  //   if (userSnapshot.connectionState == ConnectionState.waiting ||
  //       tokenSnapshot.connectionState == ConnectionState.waiting) {
  //     return const SplashScreen();
  //   }
  //   if (tokenSnapshot.data != null) return const MainScreen();
  //   return const LoginScreen();
  // }

  String? onValidateEmail(String? value) {
    return Validators.email(value) ?? Validators.required(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Poppins"),
      home: LoginFragment(),
    );

    // return Consumer<TokenViewModel>(
    //   builder: (_, state, ___) => FutureBuilder(
    //     future: state.setupToken(),
    //     builder: (_, tokenSnapshot) {
    //       return Consumer<UserViewModel>(
    //         builder: (_, state, __) => FutureBuilder(
    //           future: state.getMe(),
    //           builder: (_, userSnapshot) => FutureBuilder(
    //             future: LocalStorage().get(spKey: 'isNotFirsttime'),
    //             builder: (_, isNotFirsttimeSnapshot) => MaterialApp(
    //               title: 'Mini Project Jovin Lidan',
    //               debugShowCheckedModeBanner: false,
    //               theme: ThemeData(
    //                 primarySwatch: Colors.blue,
    //               ),
    //               routes: {
    //                 '/register': (context) => const RegisterScreen(),
    //                 '/login': (context) => const LoginScreen(),
    //                 '/create-post': (context) => const CreatePostScreen()
    //               },

    //               home: getInitialPage(
    //                   tokenSnapshot: tokenSnapshot,
    //                   userSnapshot: userSnapshot,
    //                   isNotFirsttimeSnapshot: isNotFirsttimeSnapshot),
    //               // initialRoute: '/',
    //               onGenerateRoute: onGenerateRoute,
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
