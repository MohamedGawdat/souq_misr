import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:souq_misr_elmaly/modules/home_page/presentation/providers/bank_provider.dart';
import 'package:souq_misr_elmaly/style/app_text_style.dart';
import '../../../../../style/app_colors.dart';
import '../../../../prices_history/presintation/controller/currency_history_provider.dart';
import '../../../../prices_history/presintation/ui/screen/currency_history_screen.dart';
import '../../../data/models/bank_model.dart';
import '../../../data/models/currency_model.dart';
import '../widgets/last_update_time.dart';
import '../widgets/price_arrow.dart';
import '../widgets/table_data_row.dart';

class BanksTable extends StatelessWidget {
  final List<BankModel> banks;
  final String selectedCurrency;
  const BanksTable(
      {super.key, required this.banks, required this.selectedCurrency});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TableHeaders(),
        const LastUpdateTime(),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),

          // key: ValueKey<int>(selectedCurrency.codeUnitAt(2)),
          child: _TableContent(
            key: ValueKey<String>(
                selectedCurrency), // Unique key based on selectedCurrency
            currencyList: banks
                .where((bank) => bank.currencies!
                    .any((currency) => currency.code == selectedCurrency))
                .toList(),
            selectedCurrency: selectedCurrency,
          ),
        ),
      ],
    );
  }
}

class _TableContent extends StatelessWidget {
  final List<BankModel> currencyList;
  final String selectedCurrency;

  const _TableContent(
      {super.key, required this.currencyList, required this.selectedCurrency});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CurrencyPriceChartScreen(
                  bankId: currencyList[index].id.toString(),
                  currency: selectedCurrency,
                ),
              ));
        },
        child: _BankDataRow(
          bank: currencyList[index],
          currency: currencyList[index]
              .currencies!
              .firstWhere((element) => element.code == selectedCurrency),
        ),
      ),
      separatorBuilder: (context, index) => SizedBox(height: 6.h),
      itemCount: currencyList.length,
    );
  }
}

class _TableHeaders extends StatelessWidget {
  const _TableHeaders({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => TableDataRow(
        firstCellFlex: 3,
        firstCell: Text(
          'Bank',
          style: AppTextStyle.tableHeaderLable,
        ),
        secondCell: _SortButton(
            title: 'Sell',
            isAscending: provider.isSellAscendingBanks,
            onTap: provider.toggleSellSortOrderBanks),
        thirdCell: _SortButton(
            title: 'Buy',
            isAscending: provider.isBuyAscendingBanks,
            onTap: provider.toggleBuySortOrderBanks),
      ),
    );
  }
}

class _BankDataRow extends StatelessWidget {
  final BankModel bank;
  final CurrencyModel? currency;

  const _BankDataRow({super.key, required this.bank, required this.currency});

  @override
  Widget build(BuildContext context) {
    return TableDataRow(
      lastUpdate: '${currency?.lastUpdated} minutes ago',
      firstCellFlex: 3,
      firstCell: Row(
        children: [
          Image.asset(
            'assets/banks_icons/${bank.code}.png',
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox(width: 20),
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              bank.name ?? 'N/A',
              style: AppTextStyle.tableBankCell,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      secondCell: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              currency?.sellPrice.toString() ?? 'N/A',
              style: AppTextStyle.tablePriceCell,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          UpOrDownPriceArrow(upArrow: Random().nextBool()),
        ],
      ),
      thirdCell: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              currency?.buyPrice.toString() ?? 'N/A',
              style: AppTextStyle.tablePriceCell,
              maxLines: 1,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          UpOrDownPriceArrow(upArrow: Random().nextBool())
        ],
      ),
    );
  }
}

class _SortButton extends StatelessWidget {
  final String title;
  final bool isAscending;
  final VoidCallback onTap;
  const _SortButton(
      {super.key,
      required this.onTap,
      required this.title,
      required this.isAscending});

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
                color: Provider.of<DataProvider>(context, listen: false)
                            .currentBanksSort !=
                        null
                    ? Provider.of<DataProvider>(context, listen: false)
                                .currentBanksSort!
                                .name
                                .toLowerCase() ==
                            title.toLowerCase()
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
