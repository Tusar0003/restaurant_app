import 'dart:convert';
import 'dart:io';

import 'package:prefs/prefs.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/base_json_response.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/add_to_cart.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/order.dart';
import 'package:restaurant_app/models/update_cart_item.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/constants.dart';


class CartRepository {

  addToCart(AddToCart addToCart) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.ADD_TO_CART);

      final response = await http.post(
        url,
        headers: header,
        body: addToCart.toJson()
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

  getCartItemList() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.GET_CART_ITEM_LIST +
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

  getOrderTypeList() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.GET_ORDER_TYPE_LIST);

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

  updateCart(UpdateCartItem updateCartItem) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.UPDATE_CART_ITEM);

      final response = await http.put(
          url,
          headers: header,
          body: updateCartItem.toJson()
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

  deleteCartItem(String cartId) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.DELETE_CART_ITEM + '?cart_id=$cartId');

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

  confirmOrder(Order order) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.CONFIRM_ORDER);

      final response = await http.post(
          url,
          headers: header,
          body: order.toJson()
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

  applyPromoCode(String promoCode) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.APPLY_PROMO_CODE + '?'
          'mobile_number=${Prefs.getString(Constants.MOBILE_NUMBER)}'
          '&promo_code=$promoCode');

      final response = await http.put(
          url,
          headers: header,
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
}
