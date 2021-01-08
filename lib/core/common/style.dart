import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tinggal_makan_app/feature/presentation/utils/utils.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = HexColor("#ef5350");
final Color secondaryLightColor = HexColor("#ff867c");
final Color accentColor = HexColor("#fbc02d");
final Color searchFieldColor = HexColor("#f5f5f5");

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.solway(
      fontSize: 102, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.solway(
      fontSize: 64, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.solway(fontSize: 51, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.solway(
      fontSize: 36, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.solway(fontSize: 25, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.solway(
      fontSize: 21, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.solway(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.solway(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.solway(
      fontSize: 17, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.solway(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.solway(
      fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.solway(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.solway(
      fontSize: 11, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
