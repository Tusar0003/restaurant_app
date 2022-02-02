import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/viewmodels/home_view_model.dart';
import 'package:restaurant_app/viewmodels/profile_view_model.dart';
import 'package:restaurant_app/widgets/widgets.dart';


class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MVVM(
      view: (_, __) => MyProfilePageView(),
      viewModel: ProfileViewModel(),
    );
  }
}

// ignore: must_be_immutable
class MyProfilePageView extends StatelessView<ProfileViewModel> {

  late BuildContext context;

  @override
  Widget render(BuildContext context, ProfileViewModel viewModel) {
    this.context = context;

    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  body() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: header()
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Constants.STANDARD_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                userNameLabel(),
                userNameField(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                firstNameLabel(),
                firstNameField(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                lastNameLabel(),
                lastNameField(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                mobileNumberLabel(),
                mobileNumberField(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                emailLabel(),
                emailField(),
                SizedBox(
                  height: Constants.EXTRA_EXTRA_SMALL_HEIGHT,
                ),
                addressLabel(),
                addressField(),
                SizedBox(
                  height: Constants.LARGE_PADDING,
                ),
                updateButton()
              ],
            ),
          )
        )
      ],
    );
  }

  appBar() {
    return AppBar(
      title: Text(
        Constants.MY_PROFILE,
        style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500
        ),
      ),
      backgroundColor: ColorHelper.PRIMARY_COLOR,
      elevation: 0,
    );
  }

  header() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: Constants.MEDIUM_HEIGHT,
            decoration: BoxDecoration(
                color: ColorHelper.PRIMARY_COLOR,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Constants.MEDIUM_RADIUS),
                    bottomRight: Radius.circular(Constants.MEDIUM_RADIUS)
                )
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(top: Constants.EXTRA_LARGE_PADDING),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Constants.EXTRA_LARGE_RADIUS),
                  child: FadeInImage(
                    image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/RedDot_Burger.jpg/285px-RedDot_Burger.jpg',
                    ),
                    placeholder: AssetImage('assets/images/place_holder.jpg'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image(
                        image: AssetImage('assets/images/place_holder.jpg'),
                        fit: BoxFit.fill,
                        height: Constants.MEDIUM_HEIGHT,
                        width: Constants.MEDIUM_WIDTH,
                      );
                    },
                    fit: BoxFit.fill,
                    height: Constants.MEDIUM_HEIGHT,
                    width: Constants.MEDIUM_WIDTH,
                  ),
                ),
                Positioned(
                    top: Constants.EXTRA_SMALL_PADDING,
                    right: Constants.SMALL_PADDING,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: ColorHelper.PRIMARY_COLOR,
                          shape: CircleBorder(
                              side: BorderSide(
                                  color: Colors.white
                              )
                          ),
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {}
                    )
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  firstNameLabel() {
    return Row(
      children: [
        Text(
          Constants.FIRST_NAME,
          style: GoogleFonts.poppins(
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          width: Constants.EXTRA_SMALL_PADDING,
        ),
        Widgets().mandatory()
      ],
    );
  }

  firstNameField() {
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
            hintText: Constants.FIRST_NAME,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            // prefixIcon: Icon(
            //   Icons.person,
            //   size: Constants.SMALL_ICON_SIZE,
            //   color: Colors.grey.shade500,
            // ),
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

  lastNameLabel() {
    return Row(
      children: [
        Text(
          Constants.LAST_NAME,
          style: GoogleFonts.poppins(
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          width: Constants.EXTRA_SMALL_PADDING,
        ),
        Widgets().mandatory()
      ],
    );
  }

  lastNameField() {
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
            hintText: Constants.LAST_NAME,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            // prefixIcon: Icon(
            //   Icons.person,
            //   size: Constants.SMALL_ICON_SIZE,
            //   color: Colors.grey.shade500,
            // ),
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

  userNameLabel() {
    return Row(
      children: [
        Text(
          Constants.USER_NAME,
          style: GoogleFonts.poppins(
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          width: Constants.EXTRA_SMALL_PADDING,
        ),
        Widgets().mandatory()
      ],
    );
  }

  userNameField() {
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
            hintText: Constants.USER_NAME,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            // prefixIcon: Icon(
            //   Icons.person,
            //   size: Constants.SMALL_ICON_SIZE,
            //   color: Colors.grey.shade500,
            // ),
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

  mobileNumberLabel() {
    return Row(
      children: [
        Text(
          Constants.MOBILE_NUMBER,
          style: GoogleFonts.poppins(
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          width: Constants.EXTRA_SMALL_PADDING,
        ),
        Widgets().mandatory()
      ],
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
            // prefixIcon: Icon(
            //   Icons.person,
            //   size: Constants.SMALL_ICON_SIZE,
            //   color: Colors.grey.shade500,
            // ),
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

  emailLabel() {
    return Row(
      children: [
        Text(
          Constants.EMAIL,
          style: GoogleFonts.poppins(
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          width: Constants.EXTRA_SMALL_PADDING,
        ),
        Widgets().mandatory()
      ],
    );
  }

  emailField() {
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
            hintText: Constants.EMAIL,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            // prefixIcon: Icon(
            //   Icons.person,
            //   size: Constants.SMALL_ICON_SIZE,
            //   color: Colors.grey.shade500,
            // ),
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

  addressLabel() {
    return Row(
      children: [
        Text(
          Constants.ADDRESS,
          style: GoogleFonts.poppins(
              fontSize: Constants.SMALL_FONT_SIZE,
              fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(
          width: Constants.EXTRA_SMALL_PADDING,
        ),
        Widgets().mandatory()
      ],
    );
  }

  addressField() {
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
            hintText: Constants.ADDRESS,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey.shade500,
              fontSize: Constants.MEDIUM_FONT_SIZE,
            ),
            // prefixIcon: Icon(
            //   Icons.person,
            //   size: Constants.SMALL_ICON_SIZE,
            //   color: Colors.grey.shade500,
            // ),
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

  updateButton() {
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
              Constants.UPDATE,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            )
        ),
        onPressed: () {
          // String number = phoneNumberTextController.text.toString();
          // Provider.of<AuthViewModel>(context, listen: false).checkLogIn(number.replaceAll(' ', ''));

          // Navigator.pushNamed(buildContext, AppRoute.HOME);
        },
      ),
    );
  }
}
