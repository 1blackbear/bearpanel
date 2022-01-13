import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle titleForm = GoogleFonts.roboto(
    color: AppColors.black_pattern_dark,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle titleDetailPage = GoogleFonts.roboto(
    color: AppColors.black_pattern_dark,
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle descForm = GoogleFonts.roboto(
    color: AppColors.black_pattern_dark,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle miniForm = GoogleFonts.roboto(
    color: AppColors.black_pattern_dark,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle mediumForm = GoogleFonts.roboto(
    color: AppColors.black_pattern_dark,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle linkForm = GoogleFonts.roboto(
    color: AppColors.black_pattern_dark,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );

  static final TextStyle btnStyle = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle googleBtn = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 35,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle mediaStyle = GoogleFonts.roboto(
    color: AppColors.black_pattern_dark,
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle timeStyle = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 30,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle nameStyle = GoogleFonts.roboto(
    color: AppColors.white,
    fontSize: 25,
    fontWeight: FontWeight.normal,
  );

  static final TextStyle emptyStyle = GoogleFonts.roboto(
    color: AppColors.empty,
    fontSize: 25,
    fontWeight: FontWeight.normal,
  );

}
