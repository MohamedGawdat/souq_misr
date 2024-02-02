import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:souq_misr_elmaly/modules/home_page/data/models/silver_model.dart';
import 'package:souq_misr_elmaly/style/app_colors.dart';

import '../../../../../style/app_text_style.dart';
import '../../providers/bank_provider.dart';
import '../widgets/last_update_time.dart';
import '../widgets/price_arrow.dart';
import '../widgets/table_data_row.dart';

class SilverScreenPrices extends StatelessWidget {
  final bool showHero;

  const SilverScreenPrices({super.key, this.showHero = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Silver Prices'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: ListView(
            children: [
              // const _TableHeaders(),
              const LastUpdateTime(),

              _TableHeaders(
                onSortSell: provider.toggleSellSortOrderSilver,
                onSortBuy: provider.toggleBuySortOrderSilver,
                isSellAscending: provider.isSellAscendingSilver,
                isBuyAscending: provider.isBuyAscendingSilver,
              ),
              SizedBox(height: 12.h),
              Hero(
                tag: showHero ? 'Silver' : '',
                child: Material(
                  child: TableRows(
                      silverList: provider.data!.silver
                          .where((silver) => silver.price != null) // Filter out golds with null prices
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

class TableRows extends StatelessWidget {
  final List<SilverModel> silverList;

  const TableRows({super.key, required this.silverList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) => TableDataRow(
              lastUpdate: '${silverList[index].lastUpdate} minutes ago',
              firstCell: Text(
                silverList[index].name!.replaceAll('Silver ', '').replaceAll('Gram ', ''),
                style: AppTextStyle.tableBankCell,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              secondCell: Row(
                children: [
                  Text(
                    silverList[index].price.toString() ?? 'N/A',
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
                    silverList[index].price != null ? ((double.parse(silverList[index].price!) / 100) * 99.5).toStringAsFixed(2) : 'N/A',
                    style: AppTextStyle.tablePriceCell,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  UpOrDownPriceArrow(upArrow: Random().nextBool()),
                ],
              ),
            ),
        separatorBuilder: (context, index) => SizedBox(height: 6.h),
        itemCount: silverList.length);
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
        'Silver',
        style: AppTextStyle.tableHeaderLable,
      ),
      secondCell: _buildSortButton(context, 'Sell', isSellAscending, onSortSell),
      thirdCell: _buildSortButton(context, 'Buy', isBuyAscending, onSortBuy),
    );
  }

  Widget _buildSortButton(context, String title, bool isAscending, VoidCallback onTap) {
    return InkWell(
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
              color: Provider.of<DataProvider>(context, listen: false).currentSilverSort != null
                  ? Provider.of<DataProvider>(context, listen: false).currentSilverSort!.name.toLowerCase() == title.toLowerCase()
                      ? AppColors.darkGreen
                      : AppColors.gray900
                  : null,
              key: ValueKey<bool>(isAscending),
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
