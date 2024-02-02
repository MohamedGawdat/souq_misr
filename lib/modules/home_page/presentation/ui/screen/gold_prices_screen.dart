import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:souq_misr_elmaly/extensions/string_extensions.dart';
import 'package:souq_misr_elmaly/style/app_colors.dart';

import '../../../../../style/app_text_style.dart';
import '../../../data/models/gold_model.dart';
import '../../providers/bank_provider.dart';
import '../widgets/last_update_time.dart';
import '../widgets/price_arrow.dart';
import '../widgets/table_data_row.dart';

class GoldScreenPrices extends StatelessWidget {
  final bool showHero;
  const GoldScreenPrices({super.key, this.showHero = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Gold Prices'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: ListView(
            children: [
              // const _TableHeaders(),
              _TableHeaders(
                onSortSell: provider.toggleSellSortOrderGold,
                onSortBuy: provider.toggleBuySortOrderGold,
                isSellAscending: provider.isSellAscendingGold,
                isBuyAscending: provider.isBuyAscendingGold,
              ),
              const LastUpdateTime(),
              Hero(
                tag: showHero ? 'Gold' : '',
                child: Material(
                  child: _TableRows(
                      goldList: provider.data!.gold
                          .where((gold) => gold.buyPrice != null && gold.sellPrice != null) // Filter out golds with null prices
                          .map((e) => e)
                          .toList()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableRows extends StatelessWidget {
  final List<GoldModel> goldList;

  const _TableRows({super.key, required this.goldList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => TableDataRow(
              lastUpdate: '${goldList[index].lastUpdate} minutes ago',
              firstCell: Text(
                goldList[index].name!.replaceAll('Gold', ''),
                style: AppTextStyle.tableBankCell,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              secondCell: Row(
                children: [
                  Text(
                    goldList[index].sellPrice.toWholeNumber,
                    style: AppTextStyle.tablePriceCell,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  UpOrDownPriceArrow(upArrow: Random().nextBool()),
                ],
              ),
              thirdCell: Row(
                children: [
                  Text(
                    goldList[index].buyPrice.toWholeNumber,
                    style: AppTextStyle.tablePriceCell,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  UpOrDownPriceArrow(upArrow: Random().nextBool()),
                ],
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(height: 6.h),
        itemCount: goldList.length);
  }
}

class _TableHeaders extends StatelessWidget {
  final VoidCallback onSortSell;
  final VoidCallback onSortBuy;
  final bool isSellAscending;
  final bool isBuyAscending;

  const _TableHeaders({
    super.key,
    required this.onSortSell,
    required this.onSortBuy,
    required this.isSellAscending,
    required this.isBuyAscending,
  });
  @override
  Widget build(BuildContext context) {
    return TableDataRow(
      firstCell: Text(
        'Gold',
        style: AppTextStyle.tableHeaderLable,
      ),
      secondCell: _SortButton(title: 'Sell', isAscending: isSellAscending, onTap: onSortSell),
      thirdCell: _SortButton(title: 'Buy', isAscending: isBuyAscending, onTap: onSortBuy),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String title;
  final bool isAscending;
  final VoidCallback onTap;
  const _SortButton({super.key, required this.onTap, required this.title, required this.isAscending});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, value, child) => InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: AppTextStyle.tableHeaderLable,
            ),
            SizedBox(width: 5.w),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                color: Provider.of<DataProvider>(context, listen: false).currentGoldSort != null
                    ? Provider.of<DataProvider>(context, listen: false).currentGoldSort!.name.toLowerCase() == title.toLowerCase()
                        ? AppColors.darkGreen
                        : AppColors.gray900
                    : null,
                key: ValueKey<bool>(isAscending),
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
