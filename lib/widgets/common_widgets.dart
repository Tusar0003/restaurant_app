import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/utils/constants.dart';

class CommonWidgets {

  mandatory() {
    return Text(
      Constants.MANDATORY,
      style: GoogleFonts.poppins(
          color: Colors.red,
          fontSize: Constants.SMALL_FONT_SIZE,
          fontWeight: FontWeight.w500
      ),
    );
  }
}