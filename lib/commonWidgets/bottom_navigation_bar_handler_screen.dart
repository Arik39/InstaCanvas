import 'package:flutter/material.dart';

import '../colors.dart';
import '../homeModule/screens/home_screen.dart';
import 'asset_svg_icon.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const routeName = "/dashboard";

  // ignore: prefer_const_constructors_in_immutables
  BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List pages = [
      const HomeScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[_selectedPageIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (a) {
          setState(() {
            _selectedPageIndex = a;
          });
        },
        backgroundColor: getPrimaryColor(context),
        selectedLabelStyle: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          fontWeight: FontWeight.w400,
        ),
        unselectedItemColor: getGreyColor2(context),
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            activeIcon: AssetSvgIcon(iconName: 'active_logo'),
            icon: AssetSvgIcon(iconName: 'inactive_logo'),
            label: "Home",
          ),
          BottomNavigationBarItem(
              activeIcon: AssetSvgIcon(iconName: 'active_booking_icon'),
              icon: AssetSvgIcon(iconName: "booking_icon"),
              label: "Bookings"),
          BottomNavigationBarItem(
              activeIcon: AssetSvgIcon(iconName: 'active_account_icon'),
              icon: AssetSvgIcon(iconName: "account_icon"),
              label: "Accounts")
        ],
      ),
    );
  }
}
