// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
//
// class BannerAdWidget extends StatefulWidget {
//   final String adUnitId;
//
//   const BannerAdWidget({super.key, required this.adUnitId});
//
//   @override
//   _BannerAdWidgetState createState() => _BannerAdWidgetState();
// }
//
// class _BannerAdWidgetState extends State<BannerAdWidget> {
//   BannerAd? _bannerAd;
//   bool _isBannerAdLoaded = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _createBannerAd();
//   }
//
//   void _createBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: widget.adUnitId,
//       size: AdSize.banner,
//       request: const AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (_) {
//           setState(() {
//             _isBannerAdLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }
//
//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _isBannerAdLoaded
//         ? Container(
//             alignment: Alignment.center,
//             width: _bannerAd!.size.width.toDouble(),
//             height: _bannerAd!.size.height.toDouble(),
//             child: AdWidget(ad: _bannerAd!),
//           )
//         : const SizedBox.shrink();
//   }
// }
