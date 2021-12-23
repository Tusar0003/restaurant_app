import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/repositories/sign_in_repository.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class AuthViewModel extends ViewModel {

  SignInRepository signInRepository = SignInRepository();

  var isLoading = false;
  var isPasswordInvisible = true;
  var isConfirmPasswordInvisible = true;

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

  getToken() async {
    BaseResponse baseResponse = await signInRepository.getToken();

    if (!baseResponse.isSuccess) {
      ToastMessages().showErrorToast(baseResponse.message!);
    }

    notifyListeners();
  }

  showWarningMessage(String message) {
    hideProgressBar();
    ToastMessages().showWarningToast(message);
  }
}
