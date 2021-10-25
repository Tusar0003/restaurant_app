import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/auth_view_model.dart';


late BuildContext buildContext;

class SignIn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    buildContext = context;

    return MVVM(
      view: (_, __) => SignInView(),
      viewModel: AuthViewModel()
    );
  }
}

// ignore: must_be_immutable
class SignInView extends StatelessView<AuthViewModel> {

  late AuthViewModel viewModel;

  @override
  Widget render(BuildContext context, viewModel) {

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
              height: Constants.LARGE_HEIGHT,
              width: MediaQuery.of(buildContext).size.width,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.all(Constants.STANDARD_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Constants.SIGN_IN_TO_YOUR_ACCOUNT,
                  style: GoogleFonts.poppins(
                    fontSize: Constants.LARGE_FONT_SIZE,
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                Text(
                  Constants.USER_NAME,
                  style: GoogleFonts.poppins(
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w500
                  ),
                ),
                userNameField(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                Text(
                  Constants.PASSWORD,
                  style: GoogleFonts.poppins(
                      fontSize: Constants.SMALL_FONT_SIZE,
                      fontWeight: FontWeight.w500
                  ),
                ),
                passwordField(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                forgotPassword(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                signInButton(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                signUp()
              ],
            ),
          )
        ],
      ),
    );
  }

  userNameField() {
    // var maskFormatter = MaskTextInputFormatter(
    //     mask: '+88 ### ### #####',
    //     filter: {"#": RegExp(r'[0-9]')}
    // );

    return Container(
      width: MediaQuery.of(buildContext).size.width,
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
            hintText: Constants.USER_NAME,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            prefixIcon: Icon(
              Icons.person,
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

  passwordField() {
    // var maskFormatter = MaskTextInputFormatter(
    //     mask: '+88 ### ### #####',
    //     filter: {"#": RegExp(r'[0-9]')}
    // );

    return Container(
      width: MediaQuery.of(buildContext).size.width,
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
            hintText: Constants.PASSWORD,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
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

  forgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        child: Text(
          Constants.FORGOT_PASSWORD,
          style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: Constants.MEDIUM_FONT_SIZE,
              fontWeight: FontWeight.w500
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  signInButton() {
    return Container(
      width: MediaQuery.of(buildContext).size.width,
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
              Constants.SIGN_IN,
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
              ),
            )
        ),
        onPressed: () {
          // String number = phoneNumberTextController.text.toString();
          // Provider.of<AuthViewModel>(context, listen: false).checkLogIn(number.replaceAll(' ', ''));

          Navigator.pushNamed(buildContext, AppRoute.HOME);
        },
      ),
    );
  }

  signUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Constants.DONT_HAVE_AN_ACCOUNT,
          style: GoogleFonts.poppins(
            fontSize: Constants.MEDIUM_FONT_SIZE,
            color: Colors.black
          ),
        ),
        TextButton(
          child: Text(
            Constants.SIGN_UP,
            style: GoogleFonts.poppins(
              fontSize: Constants.MEDIUM_FONT_SIZE,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            )
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
