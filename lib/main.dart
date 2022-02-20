import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/utils/FirebaseServiceHandler.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/color_helper.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/views/about_page.dart';
import 'package:restaurant_app/views/apply_promo_code_page.dart';
import 'package:restaurant_app/views/cart_page.dart';
import 'package:restaurant_app/views/home_page.dart';
import 'package:restaurant_app/views/item_details_page.dart';
import 'package:restaurant_app/views/my_order_page.dart';
import 'package:restaurant_app/views/my_profile_page.dart';
import 'package:restaurant_app/views/notification_page.dart';
import 'package:restaurant_app/views/current_order_details_page.dart';
import 'package:restaurant_app/views/search_item_page.dart';
import 'package:restaurant_app/views/sign_in_page.dart';
import 'package:restaurant_app/views/verification_page.dart';


Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ColorHelper.PRIMARY_DARK_COLOR,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String initialRoute = AppRoute.SIGN_IN;

    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      initialRoute = AppRoute.HOME;
    }

    return MaterialApp(
      title: Constants.APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorHelper.PRIMARY_COLOR,
      ),
      initialRoute: initialRoute,
      routes: {
        AppRoute.SIGN_IN: (context) => SignIn(),
        AppRoute.VERIFICATION: (context) => Verification(),
        AppRoute.HOME: (context) => HomePage(),
        AppRoute.ITEM_DETAILS: (context) => ItemDetailsPage(),
        AppRoute.CART: (context) => CartPage(),
        AppRoute.MY_PROFILE: (context) => MyProfilePage(),
        AppRoute.MY_ORDERS: (context) => MyOrderPage(),
        AppRoute.NOTIFICATIONS: (context) => NotificationPage(),
        AppRoute.APPLY_PROMO_CODE: (context) => ApplyPromoCodePage(),
        AppRoute.ORDER_DETAILS: (context) => CurrentOrderDetailsPage(),
        AppRoute.SEARCH_ITEM: (context) => SearchItemPage(),
        AppRoute.ABOUT: (context) => AboutPage(),
      },
    );
  }
}
