import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';

class Widgets {

  appBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500
        ),
      ),
      // backgroundColor: ColorHelper.TRANSPARENT_COLOR,
      // elevation: 0,
    );
  }

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

  progressBar() {
    return HUD(
        progressIndicator: CircularProgressIndicator(
            color: ColorHelper.PRIMARY_COLOR
        ),
        label: Constants.PLEASE_WAIT
    );
  }

  noItem() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: Constants.MEDIUM_WIDTH,
              height: Constants.MEDIUM_HEIGHT,
              image: AssetImage('assets/images/empty.png'),
            ),
            SizedBox(
              height: Constants.STANDARD_PADDING,
            ),
            Text(
              'No data found!',
              style: GoogleFonts.poppins(),
            ),
          ],
        )
    );
  }
}