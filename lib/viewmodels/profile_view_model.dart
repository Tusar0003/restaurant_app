import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/profile.dart';
import 'package:restaurant_app/repositories/profile_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class ProfileViewModel extends ViewModel {

  ProfileRepository profileRepository = ProfileRepository();

  bool isLoading = false;
  String userName = '';
  String mobileNumber = '';
  String email = '';
  String address = '';
  String profileImagePath = '';
  XFile? profileImage;
  bool hasImageChanged = false;

  @override
  void init() {
    getProfileData();
  }

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  setUserName(String newVal) {
    userName = newVal;
    notifyListeners();
  }

  setMobileNumber(String newVal) {
    mobileNumber = newVal;
    notifyListeners();
  }

  setEmail(String newVal) {
    email = newVal;
    notifyListeners();
  }

  setAddress(String newVal) {
    address = newVal;
    notifyListeners();
  }

  setImage(XFile? image) {
    profileImage = image;
    hasImageChanged = true;
    notifyListeners();
  }

  validationProfileData() {
    if (userName.isEmpty) {
      showWarningMessage('User is empty!');
    } else if (mobileNumber.isEmpty) {
      showWarningMessage('Mobile number is empty!');
    } else {
      var imageBase64 = '';

      if (profileImage != null) {
        final imageBytes = File(profileImage!.path).readAsBytesSync();
        imageBase64 = base64Encode(imageBytes);
      }

      Profile profile = Profile(
        mobileNumber: mobileNumber.replaceAll(' ', ''),
        userName: userName,
        email: email,
        address: address,
        profileImage: imageBase64
      );

      updateProfileData(profile);
    }
  }

  getProfileData() async {
    try {
      showProgressBar();

      BaseResponse baseResponse = await profileRepository.getProfileData();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        Profile profile = Profile.fromJson(baseResponse.data[0]);
        userName = profile.userName ?? '';
        mobileNumber = profile.mobileNumber ?? '';
        email = profile.email ?? '';
        address = profile.address ?? '';
        profileImagePath = profile.profileImagePath ?? '';
      } else {
        mobileNumber = Prefs.get(Constants.MOBILE_NUMBER);
        ToastMessages().showErrorToast(baseResponse.message!);
      }

      hideProgressBar();
    } catch(e) {
      hideProgressBar();
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }

  updateProfileData(Profile profile) async {
    try {
      showProgressBar();

      BaseResponse baseResponse = await profileRepository.updateProfile(profile);

      if (baseResponse.isSuccess) {
        ToastMessages().showSuccessToast(baseResponse.message!);
      } else {
        ToastMessages().showErrorToast(baseResponse.message!);
        hideProgressBar();
      }

      getProfileData();
    } catch(e) {
      hideProgressBar();
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }

  showWarningMessage(String message) {
    hideProgressBar();
    ToastMessages().showWarningToast(message);
  }
}
