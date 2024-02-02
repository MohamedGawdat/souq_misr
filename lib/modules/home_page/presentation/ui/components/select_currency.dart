import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:souq_misr_elmaly/style/app_text_style.dart';
import '../../providers/bank_provider.dart';

class SelectCurrency extends StatelessWidget {
  const SelectCurrency({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, provider, child) => InkWell(
        onTap: () => showCurrencyPicker(
          currencyFilter: provider.data != null
              ? provider.data!.banks
                  .expand((bank) => bank.currencies ?? [])
                  .map((currency) => currency.code.toString().toUpperCase())
                  .toSet()
                  .toList()
              : [],
          theme: CurrencyPickerThemeData(
            flagSize: 25,
            titleTextStyle: const TextStyle(fontSize: 17),
            subtitleTextStyle:
                TextStyle(fontSize: 15, color: Theme.of(context).hintColor),
            bottomSheetHeight: MediaQuery.of(context).size.height / 1.8,
            inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(0xFF8C98A8).withOpacity(0.2),
                ),
              ),
            ),
          ),
          context: context,
          showFlag: true,
          showCurrencyName: true,
          showCurrencyCode: true,
          onSelect: (Currency currency) {
            provider.changeSelectedCurrency(currency.code);
          },
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Row(
            children: [
              const Icon(Icons.swap_horizontal_circle_outlined),
              SizedBox(width: 3.w),
              Text(
                provider.selectedCurrency,
                style: AppTextStyle.tableBankCell,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
