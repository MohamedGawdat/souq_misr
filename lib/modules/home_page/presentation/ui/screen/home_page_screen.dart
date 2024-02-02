import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:souq_misr_elmaly/modules/home_page/presentation/providers/bank_provider.dart';
import '../components/banks_table.dart';
import '../components/gold_container.dart';
import '../components/select_currency.dart';
import '../components/silver_container.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).fetchBanks();
    });
  }

  void _searchBanks(String query) {
    final provider = Provider.of<DataProvider>(context, listen: false);
    provider.filterBanks(query);
  }

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Provider.of<DataProvider>(context, listen: false).fetchBanks();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سوق مصر المالي'),
        actions: const [
          SelectCurrency(),
        ],
      ),
      body: Consumer<DataProvider>(builder: (context, provider, child) {
        if (provider.data == null || provider.data!.banks.isEmpty) {
          return const Center(child: Text("No banks found or error occurred"));
        }

        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: const MaterialClassicHeader(),
          controller: _refreshController,
          onRefresh: _onRefresh,
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
            children: [
              // const WhiteRadiusRow(),
              Row(
                children: [
                  Flexible(child: GoldContainer(golds: provider.data!.gold)),
                  SizedBox(width: 10.w),
                  Flexible(child: SilverContainer(silvers: provider.data!.silver)),
                ],
              ),
              SizedBox(height: 11.h),
              // SelectCurrency(
              //   currencies: provider.data != null
              //       ? provider.data!.banks
              //           .expand((bank) => bank.currencies ?? [])
              //           .map((currency) => currency.code.toString().toUpperCase())
              //           .toSet()
              //           .toList()
              //       : [],
              //   onSelected: (item) {
              //     provider.changeSelectedCurrency(item!);
              //   },
              //   selectedCurrency: provider.selectedCurrency,
              // ),
              // const BannerAdWidget(adUnitId: ' BannerAd.testAdUnitId'),
              // SizedBox(height: 11.h),
              CustomSearchBar(onSearch: _searchBanks),
              SizedBox(height: 11.h),

              BanksTable(
                banks: provider.filteredBanks,
                selectedCurrency: provider.selectedCurrency,
              )
              // buildDataTable(provider.banks!),
            ],
          ),
        );
      }),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({super.key, required this.onSearch});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isSearchActive = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (!focusNode.hasFocus) {
        setState(() {
          isSearchActive = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Collapse the search field when tapping outside
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          isSearchActive = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isSearchActive ? MediaQuery.of(context).size.width * 0.8 : 48.0,
        height: 48.0,
        child: isSearchActive
            ? TextField(
                controller: searchController,
                focusNode: focusNode,
                onChanged: widget.onSearch,
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    alignment: AlignmentDirectional.centerEnd,
                    onPressed: () {
                      setState(() {
                        isSearchActive = false;
                        FocusScope.of(context).unfocus();
                      });
                      searchController.clear(); // Clear the search text
                      widget.onSearch("");
                    },
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.search),
                alignment: AlignmentDirectional.centerEnd,
                onPressed: () {
                  setState(() {
                    isSearchActive = true;
                    focusNode.requestFocus();
                  });
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
