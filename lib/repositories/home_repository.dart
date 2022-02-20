import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:prefs/prefs.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/base_json_response.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/constants.dart';


class HomeRepository {

  getRecommendedItemList() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.RECOMMENDED_ITEM_LIST);

      final response = await http.get(
          url,
          headers: header
      ).timeout(
          Duration(seconds: Constants.TIMEOUT_LIMIT)
      ).onError((error, stackTrace) {
        return Future.error(error!);
      });

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var baseJsonResponse = BaseJsonResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        return BaseResponse(
            baseJsonResponse.isSuccess,
            baseJsonResponse.message,
            baseJsonResponse.data
        );
      } else {
        return BaseResponse(false, Constants.CONNECTION_MESSAGE, null);
      }
    } catch (e) {
      return BaseResponse(false, Constants.EXCEPTION_MESSAGE, null);
    }
  }

  getCategoryList() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.CATEGORY_LIST);

      final response = await http.get(
          url,
          headers: header
      ).timeout(
          Duration(seconds: Constants.TIMEOUT_LIMIT)
      ).onError((error, stackTrace) {
        return Future.error(error!);
      });

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var baseJsonResponse = BaseJsonResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        return BaseResponse(
            baseJsonResponse.isSuccess,
            baseJsonResponse.message,
            baseJsonResponse.data
        );
      } else {
        return BaseResponse(false, Constants.CONNECTION_MESSAGE, null);
      }
    } catch (e) {
      return BaseResponse(false, Constants.EXCEPTION_MESSAGE, null);
    }
  }

  getItemList(String categoryCode) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.ITEM_LIST + '?category_code=$categoryCode');

      final response = await http.get(
          url,
          headers: header
      ).timeout(
          Duration(seconds: Constants.TIMEOUT_LIMIT)
      ).onError((error, stackTrace) {
        return Future.error(error!);
      });

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var baseJsonResponse = BaseJsonResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        return BaseResponse(
            baseJsonResponse.isSuccess,
            baseJsonResponse.message,
            baseJsonResponse.data
        );
      } else {
        return BaseResponse(false, Constants.CONNECTION_MESSAGE, null);
      }
    } catch (e) {
      return BaseResponse(false, Constants.EXCEPTION_MESSAGE, null);
    }
  }

  getCartItemNumber() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.GET_CART_ITEM_NUMBER +
          '?mobile_number=${Prefs.getString(Constants.MOBILE_NUMBER)}');

      final response = await http.get(
          url,
          headers: header
      ).timeout(
          Duration(seconds: Constants.TIMEOUT_LIMIT)
      ).onError((error, stackTrace) {
        return Future.error(error!);
      });

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var baseJsonResponse = BaseJsonResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        return BaseResponse(
            baseJsonResponse.isSuccess,
            baseJsonResponse.message,
            baseJsonResponse.data
        );
      } else {
        return BaseResponse(false, Constants.CONNECTION_MESSAGE, null);
      }
    } catch (e) {
      return BaseResponse(false, Constants.EXCEPTION_MESSAGE, null);
    }
  }

  getCurrentOrderList() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.GET_CURRENT_ORDER_LIST +
          '?mobile_number=${Prefs.getString(Constants.MOBILE_NUMBER)}');

      final response = await http.get(
          url,
          headers: header
      ).timeout(
          Duration(seconds: Constants.TIMEOUT_LIMIT)
      ).onError((error, stackTrace) {
        return Future.error(error!);
      });

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var baseJsonResponse = BaseJsonResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        return BaseResponse(
            baseJsonResponse.isSuccess,
            baseJsonResponse.message,
            baseJsonResponse.data
        );
      } else {
        return BaseResponse(false, Constants.CONNECTION_MESSAGE, null);
      }
    } catch (e) {
      return BaseResponse(false, Constants.EXCEPTION_MESSAGE, null);
    }
  }

  getFirebaseToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // use the returned token to send messages to users from your custom server
    String? token = await messaging.getToken(
      vapidKey: Constants.WEB_PUSH_CERTIFICATE,
    );
  }
}
