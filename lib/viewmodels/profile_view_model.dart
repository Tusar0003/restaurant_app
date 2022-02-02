import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/notification.dart' as Model;
import 'package:restaurant_app/models/profile.dart';
import 'package:restaurant_app/repositories/notification_repository.dart';
import 'package:restaurant_app/repositories/profile_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class ProfileViewModel extends ViewModel {

  ProfileRepository profileRepository = ProfileRepository();

  var isLoading = false;
  late Profile profile;

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

  getProfileData() async {
    try {
      showProgressBar();

      BaseResponse baseResponse = await profileRepository.getProfileData();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        profile = baseResponse.data[0];
      } else {
        ToastMessages().showErrorToast(baseResponse.message!);
      }

      hideProgressBar();
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
