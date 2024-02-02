import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../style/app_colors.dart';
import '../../../../../style/app_text_style.dart';

class TableDataRow extends StatelessWidget {
  final Widget firstCell;
  final Widget secondCell;
  final Widget thirdCell;
  final String? lastUpdate;
  const TableDataRow({super.key, required this.firstCell, required this.secondCell, required this.thirdCell, this.lastUpdate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200, width: 1),
        color: AppColors.baseWhite,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: firstCell,
                ),
              ),
              Flexible(
                child: Center(
                  child: secondCell,
                ),
              ),
              Flexible(
                child: Center(
                  child: thirdCell,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
