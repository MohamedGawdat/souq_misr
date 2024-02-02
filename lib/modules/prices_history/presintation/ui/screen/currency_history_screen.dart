import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/currency_history_provider.dart';

class CurrencyHistoryScreen extends StatefulWidget {
  @override
  _CurrencyHistoryScreenState createState() => _CurrencyHistoryScreenState();
}

class _CurrencyHistoryScreenState extends State<CurrencyHistoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CurrencyHistoryProvider>(context, listen: false)
            .fetchPriceHistory('1', 'USD'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency History'),
      ),
      body: Center(
        child: Consumer<CurrencyHistoryProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return CircularProgressIndicator();
            }

            if (provider.errorMessage.isNotEmpty) {
              return Text(provider.errorMessage);
            }

            if (provider.priceHistory == null) {
              return Text('No data available');
            }

            return Text(
              'History Length: ${provider.priceHistory!.changeHistory.length}',
              style: TextStyle(fontSize: 20),
            );
          },
        ),
      ),
    );
  }
}
