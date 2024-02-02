import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpOrDownPriceArrow extends StatelessWidget {
  final bool upArrow;
  const UpOrDownPriceArrow({super.key, required this.upArrow});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: upArrow
          ? const Icon(
              Icons.arrow_upward,
              color: Colors.green,
              size: 22,
            )
          : const Icon(
              Icons.arrow_downward,
              color: Colors.red,
              size: 22,
            ),
    );
  }
}
