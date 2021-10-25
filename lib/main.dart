import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/views/cart.dart';
import 'package:restaurant_app/views/home.dart';
import 'package:restaurant_app/views/item_details.dart';
import 'package:restaurant_app/views/sign_in.dart';
import 'package:restaurant_app/views/verification.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorHelper.PRIMARY_DARK_COLOR,
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tech Island Ltd.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorHelper.PRIMARY_COLOR,
      ),
      initialRoute: AppRoute.SIGN_IN,
      routes: {
        AppRoute.SIGN_IN: (context) => SignIn(),
        AppRoute.VERIFICATION: (context) => Verification(),
        AppRoute.HOME: (context) => Home(),
        AppRoute.ITEM_DETAILS: (context) => ItemDetails(),
        AppRoute.CART: (context) => Cart(),
      },
    );
  }
}
