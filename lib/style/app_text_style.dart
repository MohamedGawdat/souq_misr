import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyle {
  static TextStyle cardSellAndBuyTitle = GoogleFonts.inter(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 12.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
  );
  static TextStyle cardSellAndBuyPrice = GoogleFonts.inter(
    textStyle: TextStyle(
      color: AppColors.gray900, // Gray-900 color
      fontSize: 16.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      height: 1.5,
    ),
  );
  static TextStyle tableHeaderLable = GoogleFonts.inter(
    textStyle: TextStyle(
      color: AppColors.tableHeaderColor,
      fontFamily: 'Inter',
      fontSize: 12.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      height: 1.5,
    ),
  );
  static TextStyle tableBankCell = GoogleFonts.inter(
    textStyle: TextStyle(
      color: AppColors.gray900,
      fontFamily: 'Inter',
      fontSize: 12.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      height: 1.5, // This is equivalent to line-height 150% of the font size
    ),
  );
  static TextStyle tablePriceCell = GoogleFonts.inter(
    textStyle: TextStyle(
      color: AppColors.gray500,
      fontSize: 12.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      height: 1.5,
    ),
  );
}
