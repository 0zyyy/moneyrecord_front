import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/app_color.dart';

class AppFont {
  static TextStyle primaryTextStyle = GoogleFonts.inter(
      textStyle: TextStyle(
    fontSize: 24,
    color: AppColor.primaryTextColor,
    fontWeight: FontWeight.w600,
  ));
  static TextStyle secondaryTextStyle = GoogleFonts.inter(
      textStyle: TextStyle(
    fontSize: 14,
    color: AppColor.secondaryTextColor,
    fontWeight: FontWeight.w400,
  ));
}
