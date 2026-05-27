import 'package:insta_canvas/colors.dart';
import 'package:insta_canvas/historyModule/screens/history_screen.dart';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'authModule/provider/auth_provider.dart';
import 'commonWidgets/asset_svg_icon.dart';
import 'homeModule/screens/home_screen.dart';
import 'navigation/arguments.dart';

class BottomNavBar extends StatefulWidget {
  final BottomNavArgumnets args;

  const BottomNavBar({super.key, required this.args});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  final LocalStorage storage = LocalStorage('bys_user');

  int _currentIndex = 0;
  bool isLoading = false;
  Map language = {};

  String? notificationId;
  final unselectedColor = const Color(0xFF969698);

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _children = [
    const HomeScreen(),
    const HistoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.args.index;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dW = MediaQuery.of(context).size.width;
    language = Provider.of<AuthProvider>(context).selectedLanguage;

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: getAppBackground(context),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          selectedLabelStyle: const TextStyle(
            fontSize: 0,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 0,
          ),
          items: [
            BottomNavigationBarItem(
              icon: AssetSvgIcon(
                iconName: 'home',
                height: dW * .06,
                color: _currentIndex == 0 ? Colors.white : getIcon(context),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: AssetSvgIcon(
                iconName: 'history',
                height: dW * .06,
                color: _currentIndex == 1 ? Colors.white : getIcon(context),
              ),
              label: '',
            ),
            // BottomNavigationBarItem(
            //   icon: AssetSvgIcon(
            //     iconName: 'setting1',
            //     height: dW * .06,
            //     color: _currentIndex == 2 ? Colors.white : getIcon(context),
            //   ),
            //   label: '',
            // ),
          ],
        ),
      ),
    );
  }
}
