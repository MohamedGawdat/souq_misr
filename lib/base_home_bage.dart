import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:souq_misr_elmaly/style/app_colors.dart';

import 'modules/home_page/presentation/ui/screen/gold_prices_screen.dart';
import 'modules/home_page/presentation/ui/screen/home_page_screen.dart';
import 'modules/home_page/presentation/ui/screen/silver_prices_screen.dart';
// Replace with your actual import path

class NewBaseHomePage extends StatefulWidget {
  const NewBaseHomePage({super.key});

  @override
  State<NewBaseHomePage> createState() => _NewBaseHomePageState();
}

class _NewBaseHomePageState extends State<NewBaseHomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          MyHomePage(),
          GoldScreenPrices(),
          SilverScreenPrices(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: AppColors.mainAppColor, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1)),
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped,
              backgroundColor: AppColors.mainAppColor,
              color: Colors.grey,
              activeColor: Colors.white,
              tabBackgroundColor: AppColors.gray900,
              padding: const EdgeInsets.all(16),
              tabs: [
                GButton(
                  icon: Icons.home,
                  // backgroundColor: AppColors.gray900,
                  leading: Image.asset(
                    'assets/icons/dollar.png',
                    width: 24.w,
                    height: 24.w,
                    // height: 24,
                  ),
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.monetization_on,
                  leading: Image.asset(
                    'assets/icons/new_gold_icon.png',
                    width: 24.w,
                    // height: 24,
                  ),
                  text: 'Gold',
                ),
                GButton(
                  icon: Icons.ac_unit,
                  leading: Image.asset(
                    'assets/icons/new_silver_icon.png',
                    width: 24.w,
                    // height: 24,
                  ),
                  text: 'Silver',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
