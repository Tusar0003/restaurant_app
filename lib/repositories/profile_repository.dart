import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_json_response.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/profile.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/constants.dart';


class ProfileRepository {

  getProfileData() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.GET_PROFILE_DATA + '?mobile_number=+8801521234567');

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

  updateProfile(Profile profile) async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      var url = Uri.parse(ApiServices.PROFILE_UPDATE);

      final response = await http.post(
        url,
        headers: header,
        body: profile.toJson()
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
