import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/verification_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class Verification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => VerificationView(),
      viewModel: VerificationViewModel()
    );
  }
}

// ignore: must_be_immutable
class VerificationView extends StatelessView<VerificationViewModel> {

  late BuildContext context;
  late VerificationViewModel viewModel;

  @override
  Widget render(BuildContext context, VerificationViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        body: body(),
      )
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Constants.MEDIUM_RADIUS),
              bottomRight: Radius.circular(Constants.MEDIUM_RADIUS)
            ),
            child: Image(
              image: AssetImage('assets/images/sign_in_page_image.jpg'),
              height: Constants.EXTRA_LARGE_HEIGHT,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(Constants.STANDARD_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.VERIFY_YOUR_MOBILE_NUMBER,
                  style: GoogleFonts.poppins(
                    fontSize: Constants.EXTRA_LARGE_FONT_SIZE,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                Text(
                  Constants.PROVIDE_YOUR_OTP,
                  style: GoogleFonts.poppins(
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: Constants.LARGE_PADDING,
                ),
                pinCodeTextField(),
                SizedBox(
                  height: Constants.LARGE_PADDING,
                ),
                verifyButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  pinCodeTextField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: PinCodeTextField(
        appContext: context,
        keyboardType: TextInputType.number,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldOuterPadding: EdgeInsets.only(right: Constants.EXTRA_SMALL_PADDING),
          borderRadius: BorderRadius.circular(Constants.EXTRA_SMALL_RADIUS),
          fieldHeight: Constants.EXTRA_SMALL_HEIGHT,
          fieldWidth: Constants.EXTRA_SMALL_WIDTH,
          activeFillColor: Colors.white,
          activeColor: ColorHelper.PRIMARY_COLOR,
          inactiveColor: ColorHelper.PRIMARY_COLOR,
          inactiveFillColor: Colors.white,
          selectedFillColor: ColorHelper.PRIMARY_COLOR,
          selectedColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        // controller: otpTextEditingController,
        onCompleted: (value) {},
        onChanged: (value) {
          viewModel.setOtp(value);
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }

  verifyButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Constants.EXTRA_SMALL_HEIGHT,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.EXTRA_SMALL_RADIUS)
            ),
            primary: ColorHelper.PRIMARY_COLOR
        ),
        child: Center(
            child: Text(
              Constants.VERIFY,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            )
        ),
        onPressed: () {
          viewModel.verifyMobileNumber();
        },
      ),
    );
  }
}
