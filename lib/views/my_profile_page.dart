import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hud/flutter_hud.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
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
  late ProfileViewModel viewModel;

  var maskFormatter = MaskTextInputFormatter(
      mask: '+88 ### ### #####',
      type: MaskAutoCompletionType.lazy
  );

  @override
  Widget render(BuildContext context, ProfileViewModel viewModel) {
    this.context = context;
    this.viewModel = viewModel;

    return WidgetHUD(
      showHUD: viewModel.isLoading,
      hud: Widgets().progressBar(),
      builder: (context) => Scaffold(
        appBar: appBar(),
        body: body(),
      )
    );
  }

  body() {
    return Column(
      children: [
        header(),
        Expanded(
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
    return Container(
      height: 230,
      child: Stack(
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
                                    color: ColorHelper.PRIMARY_DARK_COLOR
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
      child: TextFormField(
        initialValue: viewModel.userName == '' ? null : viewModel.userName,
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
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(Constants.MEDIUM_PADDING)
        ),
        onChanged: (String newVal) {
          viewModel.setUserName(newVal);
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
      child: TextFormField(
        initialValue: viewModel.mobileNumber == '' ? null : viewModel.mobileNumber,
        inputFormatters: [maskFormatter],
        textAlign: TextAlign.start,
        cursorColor: Colors.black54,
        keyboardType: TextInputType.phone,
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
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(Constants.MEDIUM_PADDING)
        ),
        onChanged: (String newVal) {
          viewModel.setMobileNumber(newVal);
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
      ],
    );
  }

  emailField() {
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
      child: TextFormField(
        initialValue: viewModel.email == '' ? null : viewModel.email,
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
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(Constants.MEDIUM_PADDING)
        ),
        onChanged: (String newVal) {
          viewModel.setEmail(newVal);
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
      ],
    );
  }

  addressField() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Constants.SMALL_HEIGHT,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.grey.shade300
          ),
          borderRadius: BorderRadius.circular(Constants.EXTRA_SMALL_RADIUS)
      ),
      child: TextFormField(
        initialValue: viewModel.address == '' ? null : viewModel.address,
        textAlign: TextAlign.start,
        cursorColor: Colors.black54,
        keyboardType: TextInputType.text,
        maxLines: 5,
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
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(Constants.MEDIUM_PADDING)
        ),
        onChanged: (String newVal) {
          viewModel.setAddress(newVal);
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
          viewModel.validationProfileData();
        },
      ),
    );
  }
}
