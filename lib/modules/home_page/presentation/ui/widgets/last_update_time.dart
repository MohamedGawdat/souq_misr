import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../style/app_text_style.dart';

class LastUpdateTime extends StatelessWidget {
  const LastUpdateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Text(
          '↺ 1 Minutes ago',
          style: AppTextStyle.tablePriceCell.copyWith(fontSize: 10.sp),
        ),
      ),
    );
  }
}
