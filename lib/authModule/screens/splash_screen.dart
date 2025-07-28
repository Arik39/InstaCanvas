import 'package:flutter/material.dart';

import '../../navigation/arguments.dart';
import '../../navigation/navigators.dart';
import '../../navigation/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) async {
      myInit();
    });
  }

  myInit() async {
    pushAndRemoveUntil(NamedRoute.bottomNavigation,
        arguments: BottomNavArgumnets(index: 0));
  }

  @override
  Widget build(BuildContext context) {
    final double dW = MediaQuery.of(context).size.width;
    final double dH = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: dH,
        child: Container(),
      ),
    );
  }
}
