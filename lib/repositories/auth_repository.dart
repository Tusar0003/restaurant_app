import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_json_response.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/utils/api_services.dart';
import 'package:restaurant_app/utils/constants.dart';


class AuthRepository {

  late ValueChanged<BaseResponse> onVerification;
  late ValueChanged<BaseResponse> onAuthComplete;

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
        await Prefs.setString(Constants.TOKEN, baseJsonResponse.data);

        return BaseResponse(baseJsonResponse.isSuccess, baseJsonResponse.message, null);
      } else {
        return BaseResponse(false, Constants.CONNECTION_MESSAGE, null);
      }
    } catch (exception) {
      return BaseResponse(false, Constants.EXCEPTION_MESSAGE, null);
    }
  }

  verifyPhoneNumber(String mobileNumber, ValueChanged<BaseResponse> onVerification) async {
    try {
      this.onVerification = onVerification;
      BaseResponse baseResponse;

      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: mobileNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          baseResponse = BaseResponse(false, e.message.toString(), null);
          onVerification(baseResponse);
        },
        codeSent: (String verificationId, int? resendToken) async {
          await Prefs.setString(Constants.MOBILE_NUMBER, mobileNumber.replaceAll(' ', ''));
          await Prefs.setString(Constants.VERIFICATION_ID, verificationId);

          baseResponse = BaseResponse(true, null, verificationId);
          this.onVerification(baseResponse);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (exception) {
      this.onVerification(BaseResponse(false, Constants.EXCEPTION_MESSAGE, null));
    }
  }

  signInWithCredential(String code, ValueChanged<BaseResponse> onAuthComplete) async {
    try {
      this.onAuthComplete = onAuthComplete;
      final FirebaseAuth auth = FirebaseAuth.instance;
//    auth.signOut();

      await Prefs.init();
      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: Prefs.get(Constants.VERIFICATION_ID),
          smsCode: code
      );

      await auth.signInWithCredential(phoneAuthCredential).whenComplete(() {
        BaseResponse baseResponse = BaseResponse(true, null, null);
        this.onAuthComplete(baseResponse);
      });
    } on FirebaseAuthException catch (e) {
      return BaseResponse(false, 'Verification failed!', null);
    }
  }

  signUp() async {
    try {
      await Prefs.init();
      var token = Prefs.getString(Constants.TOKEN);

      final Map<String, String> header = {
        HttpHeaders.authorizationHeader: 'Bearer ' + token
      };
      final Map<String, String> body = {
        'mobile_number': Prefs.get(Constants.MOBILE_NUMBER)
      };
      var url = Uri.parse(ApiServices.SIGN_UP);

      final response = await http.post(
        url,
        headers: header,
        body: body
      ).timeout(
          Duration(seconds: Constants.TIMEOUT_LIMIT)
      ).onError((error, stackTrace) {
        return Future.error(error!);
      });

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      var baseJsonResponse = BaseJsonResponse.fromJson(jsonResponse);

      if (response.statusCode == 200) {
        return BaseResponse(baseJsonResponse.isSuccess, baseJsonResponse.message, null);
      } else {
        return BaseResponse(false, Constants.CONNECTION_MESSAGE, null);
      }
    } catch (e) {
      return BaseResponse(false, Constants.EXCEPTION_MESSAGE, null);
    }
  }
}
