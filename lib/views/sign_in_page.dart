import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/auth_view_model.dart';


class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => SignInView(),
      viewModel: AuthViewModel()
    );
  }
}

// ignore: must_be_immutable
class SignInView extends StatelessView<AuthViewModel> {

  late BuildContext context;
  late AuthViewModel viewModel;

  @override
  Widget render(BuildContext context, viewModel) {

    this.context = context;
    this.viewModel = viewModel;

    return Scaffold(
      body: body(),
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
                  Constants.WELCOME_TO_RESTAURANT,
                  style: GoogleFonts.poppins(
                    fontSize: Constants.EXTRA_LARGE_FONT_SIZE,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                Text(
                  Constants.SIGN_IN_TO_YOUR_ACCOUNT,
                  style: GoogleFonts.poppins(
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: Constants.SIGN_IN_PAGE_PADDING,
                ),
                Text(
                  Constants.MOBILE_NUMBER,
                  style: GoogleFonts.poppins(
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w500
                  ),
                ),
                mobileNumberField(),
                SizedBox(
                  height: Constants.SIGN_IN_PAGE_PADDING,
                ),
                signInButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  mobileNumberField() {
    // var maskFormatter = MaskTextInputFormatter(
    //     mask: '+88 ### ### #####',
    //     filter: {"#": RegExp(r'[0-9]')}
    // );

    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey.shade300
          ),
          borderRadius: BorderRadius.circular(Constants.EXTRA_SMALL_RADIUS)
      ),
      child: TextField(
        // controller: phoneNumberTextController,
        // inputFormatters: [maskFormatter, LengthLimitingTextInputFormatter(18)],
        textAlign: TextAlign.start,
        cursorColor: Colors.black54,
        keyboardType: TextInputType.text,
        style: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: Constants.MEDIUM_FONT_SIZE,
        ),
        decoration: InputDecoration(
            hintText: Constants.MOBILE_NUMBER,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            prefixIcon: Icon(
              Icons.phone_android,
              size: Constants.SMALL_ICON_SIZE,
              color: Colors.grey.shade500,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(Constants.MEDIUM_PADDING)
        ),
        onChanged: (String newVal) {
//          if (newVal.length > 3) {
//            _phoneNumberTextController.text = _phoneNumberTextController.text + " ";
//          }
        },
      ),
    );
  }

  signInButton() {
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
              Constants.SEND_OTP,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            )
        ),
        onPressed: () {
          // String number = phoneNumberTextController.text.toString();
          // Provider.of<AuthViewModel>(context, listen: false).checkLogIn(number.replaceAll(' ', ''));

          Navigator.pushNamed(context, AppRoute.VERIFICATION);
        },
      ),
    );
  }
}
