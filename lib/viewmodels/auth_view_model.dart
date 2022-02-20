import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/repositories/auth_repository.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class AuthViewModel extends ViewModel {

  AuthRepository authRepository = AuthRepository();

  var isLoading = false;
  var isPasswordInvisible = true;
  var isConfirmPasswordInvisible = true;
  String mobileNumber = '';

  @override
  void init() {
    getToken();
  }

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  onPressedPasswordToggle() {
    isPasswordInvisible = !isPasswordInvisible;
    notifyListeners();
  }

  setMobileNumber(String newVal) {
    mobileNumber = newVal;
    notifyListeners();
  }

  getToken() async {
    BaseResponse baseResponse = await authRepository.getToken();

    if (!baseResponse.isSuccess) {
      ToastMessages().showErrorToast(baseResponse.message!);
    }
  }

  sendOtp() async {
    if (mobileNumber.isEmpty) {
      ToastMessages().showWarningToast('Mobile number is empty!');
      return;
    }

    showProgressBar();
    BaseResponse? baseResponse = await authRepository.verifyPhoneNumber(
        mobileNumber,
        onVerification
    );

    // if (baseResponse != null && !baseResponse.isSuccess) {
    //   ToastMessages().showErrorToast(baseResponse.message!);
    // }
  }

  onVerification(BaseResponse baseResponse) {
    if (baseResponse.isSuccess) {
      Navigator.pushNamed(context, AppRoute.VERIFICATION);
    } else {
      ToastMessages().showErrorToast(baseResponse.message!);
    }

    hideProgressBar();
  }
}
