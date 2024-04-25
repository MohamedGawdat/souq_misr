import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controller/currency_history_provider.dart';

class CurrencyPriceChartScreen extends StatefulWidget {
  final String currency;
  final String bankId;

  const CurrencyPriceChartScreen(
      {super.key, required this.currency, required this.bankId});

  @override
  _CurrencyPriceChartState createState() => _CurrencyPriceChartState();
}

class _CurrencyPriceChartState extends State<CurrencyPriceChartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  void _fetchData() async {
    await Provider.of<CurrencyHistoryProvider>(context, listen: false)
        .resetData();
    if (!mounted) return;
    await Provider.of<CurrencyHistoryProvider>(context, listen: false)
        .fetchPriceHistory(widget.bankId, widget.currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Price Chart')),
      body: Consumer<CurrencyHistoryProvider>(
        builder: (context, provider, child) => provider.priceHistory == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 0.35.sh,
                      child: LineChart(
                        LineChartData(
                          minX: provider.minX,
                          maxX: provider.maxX,
                          minY: provider.minY,
                          maxY: provider.maxY,
                          titlesData: FlTitlesData(
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final date =
                                      DateTime.fromMillisecondsSinceEpoch(
                                          value.toInt());
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                        DateFormat('dd/MM').format(date),
                                        style: const TextStyle(fontSize: 10)),
                                  );
                                },
                                interval: (provider.maxX - provider.minX) / 6,
                                reservedSize: 30,
                              ),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: provider.sellChartData,
                              isCurved: true,
                              color: Colors.red,
                              dotData: const FlDotData(show: false),
                            ),
                            LineChartBarData(
                              spots: provider.buyChartData,
                              isCurved: true,
                              color: Colors.blue,
                              dotData: const FlDotData(show: false),
                            ),
                          ],
                          // Other configurations...
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: provider.daysWithRecords.length,
                      itemBuilder: (context, index) {
                        final dayRecord = provider.daysWithRecords[index];
                        return Card(
                          elevation: 0,
                          child: ExpansionTile(
                            trailing: dayRecord.childRecords.isEmpty
                                ? const SizedBox()
                                : null,
                            enabled: dayRecord.childRecords.isNotEmpty,
                            title: Text(DateFormat('dd/MMM/yyyy').format(
                                DateTime.parse(
                                    dayRecord.parentRecord.recordedAt!))),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Table(
                                  // Define column widths
                                  columnWidths: const {
                                    0: FlexColumnWidth(3), // Time
                                    1: FlexColumnWidth(3), // Sell Price
                                    2: FlexColumnWidth(3), // Buy Price
                                  },
                                  border: TableBorder.all(
                                      color: Colors
                                          .grey), // Add border to the table
                                  children: [
                                    const TableRow(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Time',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Sell Price',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Buy Price',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    ...dayRecord.childRecords.map((record) {
                                      return TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              DateFormat('hh:mm a').format(
                                                  DateTime.parse(
                                                      record.recordedAt!)),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                record.sellPrice.toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                record.buyPrice.toString()),
                                          ),
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
