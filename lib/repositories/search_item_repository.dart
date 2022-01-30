import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_json_response.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/constants.dart';


class SearchItemRepository {

  getSearchItemList(String searchString) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.SEARCH_ITEM_LIST + '?search_string=$searchString');

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
}
