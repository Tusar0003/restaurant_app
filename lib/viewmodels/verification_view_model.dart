import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/repositories/auth_repository.dart';
import 'package:restaurant_app/utils/app_route.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class VerificationViewModel extends ViewModel {

  AuthRepository authRepository = AuthRepository();

  var isLoading = false;
  var isPasswordInvisible = true;
  var isConfirmPasswordInvisible = true;
  String otp = '';

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  setOtp(String newVal) {
    otp = newVal;
    notifyListeners();
  }

  verifyMobileNumber() async {
    if (otp.isEmpty) {
      ToastMessages().showWarningToast('OTP is empty!');
      return;
    }

    showProgressBar();
    BaseResponse? baseResponse = await authRepository.signInWithCredential(
        otp,
        onAuthComplete
    );
  }

  onAuthComplete(BaseResponse baseResponse) {
    if (baseResponse.isSuccess) {
      Navigator.pushNamed(context, AppRoute.HOME);
    } else {
      ToastMessages().showErrorToast(baseResponse.message!);
    }

    hideProgressBar();
  }
}
