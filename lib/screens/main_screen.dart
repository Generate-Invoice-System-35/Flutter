import 'package:flutter/material.dart';
import 'package:flutter_capstone_project/helpers/providers/fragment_manager.dart';
import 'package:flutter_capstone_project/widgets/bottom_navigator.dart';
import 'package:flutter_capstone_project/widgets/common/overlay_handler.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int curPage = 1;
  void handleChangePage(int page) {
    setState(() => curPage = page);
    context.read<FragmentManager>().untrackedCurrentIdx = page;
  }

  Future<bool> handleBackPressed(BuildContext context) {
    final bool isEmpty = context.read<FragmentManager>().isEmpty();
    if (isEmpty) {
      Navigator.pop(context);
      return Future.value(false);
    }
    context.read<FragmentManager>().pop();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomBar> pages = context.read<FragmentManager>().pages;

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          body: WillPopScope(
            onWillPop: () => handleBackPressed(context),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/gradient-bg.png"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
                pages[curPage].child,
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigator(
            pages: pages,
            curPage: curPage,
            onChangePage: handleChangePage,
          ),
        ),
        const OverlayHandler(),
      ],
    );
  }
}
