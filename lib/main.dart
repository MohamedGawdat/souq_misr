import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:souq_misr_elmaly/main_provider.dart';
import 'package:souq_misr_elmaly/style/app_colors.dart';
import 'package:souq_misr_elmaly/style/theme.dart';
import 'package:provider/provider.dart';
import 'data/cache/CacheUtil.dart';
import 'data/network/api_auth.dart';

import 'modules/home_page/domain/usecases/di.dart';
import 'modules/home_page/domain/usecases/get_banks_usecase.dart';
import 'modules/home_page/presentation/ui/screen/gold_prices_screen.dart';
import 'modules/home_page/presentation/ui/screen/home_page_screen.dart';
import 'modules/home_page/presentation/providers/bank_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'modules/home_page/presentation/ui/screen/silver_prices_screen.dart';
import 'modules/prices_history/domain/use_cases/GetCurrencyHistoryUseCase.dart';
import 'modules/prices_history/presintation/controller/currency_history_provider.dart';
import 'modules/splash_screen/controller/splash_screen_provider.dart';
import 'modules/splash_screen/ui/splash_screen.dart';
import 'injection_container.dart' as di;

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  AppAuth.init();
  di.init();
  // setupServiceLocator();

  await CacheUtil.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => DataProvider(getDataUseCase: getIt<GetHomeDataUseCase>())),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => CurrencyHistoryProvider(getIt<GetCurrencyHistoryUseCase>())),
      ChangeNotifierProvider(create: (context) => SplashScreenProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: AppTheme.mainTheme(),
        darkTheme: AppTheme.mainTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}

class BaseHomePage extends StatefulWidget {
  const BaseHomePage({super.key});

  @override
  State<BaseHomePage> createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  List<Widget> _buildScreens() {
    return [const MyHomePage(), const GoldScreenPrices(), const SilverScreenPrices()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/dollar.png'),
        title: ("Home"),
        activeColorSecondary: AppColors.gray900,
        activeColorPrimary: AppColors.primaryGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/new_gold_icon.png'),
        title: ("Gold"),
        activeColorPrimary: AppColors.primaryGold,
        activeColorSecondary: AppColors.gray900,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/icons/new_silver_icon.png'),
        title: ("Silver"),
        activeColorPrimary: AppColors.primarySilver,
        activeColorSecondary: AppColors.gray900,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).controller = PersistentTabController(
      initialIndex: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => PersistentTabView(
        context,
        controller: value.controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: AppColors.mainAppColor,
        // backgroundColor: AppColors.surfaceLight,

        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
      ),
    );
  }
}
