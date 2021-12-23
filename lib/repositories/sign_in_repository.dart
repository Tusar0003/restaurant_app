import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_json_response.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/constants.dart';


class SignInRepository {

  getToken() async {
    try {
      final Map<String, String> header = {
        'username': 'XlaKSk4G6IBT0Q/DXA+ZA9h6TwGiO8fcJOSDaVD7g+c=',
        'password': 'v+x3Mc8IEmECu8M87FSf+fWqU5vPi6meJ8CcNnj8PYkCIHwT1JVy8tQSop5Fmbld'
      };
      var url = Uri.parse(ApiServices.GET_TOKEN);

      final response = await http.post(
          url,
          headers: header
      ).timeout(
          Duration(seconds: Constants.TIMEOUT_LIMIT)
      ).onError((error, stackTrace) {
        return Future.error(error!);
      });

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var baseJsonResponse = BaseJsonResponse.fromJson(jsonResponse);

      if (response.statusCode == 200 && baseJsonResponse.isSuccess) {
        // await Prefs.init();
        await Prefs.setString(Constants.TOKEN, baseJsonResponse.data);
        await Prefs.setString(Constants.MOBILE_NUMBER, '+8801521234567');

        return BaseResponse(baseJsonResponse.isSuccess, baseJsonResponse.message, null);
      } else {
        return BaseResponse(false, 'Could not get token!', null);
      }
    } catch (exception) {
      return BaseResponse(false, 'Could not get token!', null);
    }
  }
}
