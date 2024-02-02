import 'package:flutter/material.dart';

import '../../../../../style/app_text_style.dart';

class BaseStyledContainer extends StatelessWidget {
  final EdgeInsets padding;
  final BorderRadius borderRadius;
  final List<Color> gradientColors;
  final List<double> gradientStops;
  final String icon;
  final String sellPrice;
  final String buyPrice;

  const BaseStyledContainer({
    super.key,
    this.padding = const EdgeInsets.all(12.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    required this.gradientColors,
    required this.gradientStops,
    required this.icon,
    required this.sellPrice,
    required this.buyPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
          stops: gradientStops,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      const SolidItemSubTitle(title: 'Sell'),
                      SolidItemPrice(sellPrice: sellPrice),
                    ],
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Column(
                    children: [
                      const SolidItemSubTitle(title: 'Buy'),
                      SolidItemPrice(sellPrice: buyPrice),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SolidItemSubTitle extends StatelessWidget {
  final String title;
  const SolidItemSubTitle({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.cardSellAndBuyTitle,
      overflow: TextOverflow.ellipsis, // This will add ellipsis for text overflow
      maxLines: 1, // This will ensure the text is in a single line
    );
  }
}

class SolidItemPrice extends StatelessWidget {
  const SolidItemPrice({
    super.key,
    required this.sellPrice,
  });

  final String sellPrice;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Text(
      sellPrice,
      style: AppTextStyle.cardSellAndBuyPrice,
      textAlign: TextAlign.right,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    ));
  }
}
