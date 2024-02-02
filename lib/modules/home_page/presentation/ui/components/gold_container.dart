import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:souq_misr_elmaly/extensions/string_extensions.dart';
import 'package:souq_misr_elmaly/main_provider.dart';
import 'package:souq_misr_elmaly/modules/home_page/data/models/gold_model.dart';
import 'package:souq_misr_elmaly/modules/home_page/presentation/ui/components/solid_price_card.dart';
import 'package:souq_misr_elmaly/modules/home_page/presentation/ui/screen/gold_prices_screen.dart';

import '../../providers/bank_provider.dart';

class GoldContainer extends StatelessWidget {
  final List<GoldModel> golds;
  const GoldContainer({super.key, required this.golds});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => InkWell(
        onTap: () {
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: const GoldScreenPrices(
          //     showHero: true,
          //   ),
          //   withNavBar: false,
          //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
          // );
          // Provider.of<HomeProvider>(context, listen: false).moveToTap(1);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GoldScreenPrices(
                  showHero: true,
                ),
              ));
        },
        child: Hero(
          tag: 'Gold',
          child: BaseStyledContainer(
            gradientColors: const [Color(0xFFFDDDA0), Color(0xFFC9A869)],
            gradientStops: const [0.2239, 0.8453],
            icon: 'assets/icons/new_gold_icon.png',
            buyPrice: (provider.data!.gold.firstWhere((element) => element.code == 'GOLD21').buyPrice!).toWholeNumber,
            sellPrice: (provider.data!.gold.firstWhere((element) => element.code == 'GOLD21').sellPrice!).toWholeNumber,
          ),
        ),
      ),
    );
  }
}
