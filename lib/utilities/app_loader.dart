// class AppLoader extends StatelessWidget {
//   const AppLoader({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SpinKitRotatingCircle(
//       color: Colors.grey,
//       size: 50.0,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoader {
  static Widget appLoaderWidget() {
    return const SpinKitPulse(
      color: Colors.grey,
      size: 80.0,
    );
  }

  static Widget appLoaderShimmerWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 48.0,
            height: 48.0,
            color: Colors.white,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: double.infinity,
                  height: 8.0,
                  color: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                ),
                Container(
                  width: 40.0,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget appLoaderChecker({required var value, required Widget child}) {
    return value == null ? appLoaderWidget() : child;
  }
}
