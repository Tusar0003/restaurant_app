import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets().appBar(Constants.ABOUT),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: Constants.EXTRA_SMALL_HEIGHT,
          bottom: Constants.STANDARD_PADDING,
          left: Constants.STANDARD_PADDING,
          right: Constants.STANDARD_PADDING
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              size: Constants.EXTRA_LARGE_ICON_SIZE,
              color: ColorHelper.PRIMARY_COLOR,
            ),
            SizedBox(
              height: Constants.SMALL_PADDING,
            ),
            Text(
              Constants.APP_NAME,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: Constants.LARGE_FONT_SIZE,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(
              height: Constants.EXTRA_SMALL_PADDING,
            ),
            version(),
            SizedBox(
              height: Constants.STANDARD_PADDING,
            ),
            Text(
              'Description about the app\n'
                  'It is a long established fact that a reader will be '
                  'distracted by the readable content of a page when looking at its layout',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: Constants.SMALL_FONT_SIZE,
                  // fontWeight: FontWeight.w600
              ),
            ),
            Spacer(),
            SizedBox(
              height: Constants.SMALL_PADDING,
            ),
            Text(
              'All Copyrights ${Constants.COPYRIGHTS_SYMBOL} Reserved'
                  '\n& Developed by Tech Island Ltd.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(
              height: Constants.SMALL_PADDING,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.link,
                  size: Constants.EXTRA_SMALL_ICON_SIZE,
                ),
                SizedBox(
                  width: Constants.EXTRA_SMALL_PADDING,
                ),
                Text(
                  'https://techisland.xyz/',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Constants.EXTRA_SMALL_PADDING,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  size: Constants.EXTRA_SMALL_ICON_SIZE,
                ),
                SizedBox(
                  width: Constants.EXTRA_SMALL_PADDING,
                ),
                Text(
                  'techislandbdltd@gmail.com',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Constants.EXTRA_SMALL_PADDING,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone_android,
                  size: Constants.EXTRA_SMALL_ICON_SIZE,
                ),
                SizedBox(
                  width: Constants.EXTRA_SMALL_PADDING,
                ),
                Text(
                  '+8801833395432',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  version() {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '${Constants.VERSION}: ${snapshot.data!.version}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: Constants.MEDIUM_FONT_SIZE,
                  fontWeight: FontWeight.w500
                ),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
