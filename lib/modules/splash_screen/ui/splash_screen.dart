import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:souq_misr_elmaly/style/app_text_style.dart';
import '../../../base_home_bage.dart';
import '../../../main.dart';
import '../../../style/app_colors.dart';
import '../../home_page/presentation/providers/bank_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetch();
    });
  }

  fetch() async {
    await Provider.of<DataProvider>(context, listen: false).fetchBanks().then((value) {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const NewBaseHomePage(),
      //   ),
      // );
    });
  }

  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    // controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: AppColors.gray900,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInUp(
                      from: 200,
                      child: Lottie.asset(
                        'assets/animations/new_logo.json',
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward().whenComplete(() => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const NewBaseHomePage()),
                                ));
                        },
                      ),
                    ),

                    // SlideInDown(
                    //   child: Column(
                    //     children: [
                    //       // Text(
                    //       //   ' Souq Misr ElMaly || سوق مصر المالي',
                    //       //   style: AppTextStyle.cardSellAndBuyPrice.copyWith(fontSize: 18.sp, fontWeight: FontWeight.w700),
                    //       // ),
                    //       SizedBox(
                    //         height: 20.h,
                    //       ),
                    //       Image.asset(
                    //         'assets/icon/icon.png',
                    //         width: 0.5.sw,
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     LinearPercentIndicator(
                    //       width: 0.75.sw,
                    //       lineHeight: 14.0,
                    //       percent: 0.9,
                    //       animation: true,
                    //       animationDuration: 1500,
                    //       backgroundColor: Colors.white,
                    //       progressColor: AppColors.primaryGold,
                    //       barRadius: const Radius.circular(8),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
                Container(
                  height: 10.h,
                  color: AppColors.primaryGold,
                )
              ],
            ),
          )),
    );
  }
}
