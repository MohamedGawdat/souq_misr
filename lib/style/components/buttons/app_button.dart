// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import '../../../utilities/connictivity.dart';
// import '../../app_colors.dart';
// import '../../app_text_style.dart';
//
// class AppBuildButton extends StatelessWidget {
//   final String title;
//   final Function action;
//   final bool showLoader;
//   final bool isMainColor;
//   final Color? color;
//   final double radius;
//   const AppBuildButton(
//       {Key? key,
//       required this.title,
//       required this.action,
//       this.showLoader = false,
//       this.isMainColor = true,
//       this.color,
//       this.radius = 18})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ArgonButton(
//       roundLoadingShape: false,
//       width: 0.8.sw,
//       height: 0.08.sh,
//       borderRadius: radius,
//       color: color ??
//           (isMainColor ? AppColors.mainAppColor : AppColors.mainAppColor2),
//       child: Container(
//         width: 0.8.sw,
//         height: 0.07.sh,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(18.0),
//           // boxShadow: isMainColor
//           //     ? null
//           //     : [
//           //         BoxShadow(
//           //             color: Colors.black26,
//           //             offset: Offset(0, 4),
//           //             blurRadius: 5.0)
//           //       ],
//           // gradient: isMainColor
//           //     ? null
//           //     : LinearGradient(
//           //         begin: Alignment.topLeft,
//           //         end: Alignment.bottomRight,
//           //         // stops: [0.0, 2.0],
//           //         colors: [
//           //           AppColors.secAppColor1,
//           //           AppColors.secAppColor2,
//           //           // Colors.deepPurple.shade200,
//           //         ],
//           //       ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: FittedBox(
//               child: Text(
//                 title,
//                 style: AppTextStyle.textButtons,
//               ),
//             ),
//           ),
//         ),
//       ),
//       loader: const SpinKitFadingCircle(
//         color: Colors.white,
//       ),
//       onTap: (startLoading, stopLoading, btnState) async {
//         try {
//           if (showLoader) {
//             if (await checkInternetConnection()) {
//               if (btnState == ButtonState.Idle) {
//                 startLoading();
//                 await action();
//                 stopLoading();
//               }
//             }
//           } else {
//             action();
//           }
//         } catch (e) {
//           stopLoading();
//         }
//         // stopLoading();
//       },
//     );
//   }
// }
