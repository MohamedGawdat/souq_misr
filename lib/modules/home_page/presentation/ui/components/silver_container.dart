import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:souq_misr_elmaly/modules/home_page/data/models/silver_model.dart';
import 'package:souq_misr_elmaly/modules/home_page/presentation/ui/components/solid_price_card.dart';
import 'package:souq_misr_elmaly/modules/home_page/presentation/ui/screen/silver_prices_screen.dart';

import '../../../../../main_provider.dart';
import '../../providers/bank_provider.dart';

class SilverContainer extends StatelessWidget {
  final List<SilverModel> silvers;

  const SilverContainer({super.key, required this.silvers});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SilverScreenPrices(
                  showHero: true,
                ),
              ));
          // PersistentNavBarNavigator.pushNewScreen(
          //   context,
          //   screen: const SilverScreenPrices(showHero: true),
          //   withNavBar: false,
          //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
          // );
          // Provider.of<HomeProvider>(context, listen: false).moveToTap(2);
        },
        child: Hero(
          tag: 'Silver',
          child: BaseStyledContainer(
            gradientColors: const [Color(0xFF919193), Color(0xFFFEFEFE), Color(0xFFE4E4E4)],
            gradientStops: const [-0.3259, 0.566, 0.8673],
            icon: 'assets/icons/new_silver_icon.png',
            buyPrice: silvers.first.price!,
            sellPrice: (double.parse(silvers.first.price!) * 0.995).toStringAsFixed(2),
          ),
        ),
      ),
    );
  }
}
