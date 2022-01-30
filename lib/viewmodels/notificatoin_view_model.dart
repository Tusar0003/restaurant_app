import 'package:pmvvm/pmvvm.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/notification.dart' as Model;
import 'package:restaurant_app/repositories/notification_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class NotificationViewModel extends ViewModel {

  NotificationRepository notificationRepository = NotificationRepository();

  var isLoading = false;
  bool isNotificationDataFound = false;

  List<Model.Notification> notificationList = [];

  @override
  void init() {
    getNotificationList();
  }

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  getNotificationList() async {
    try {
      showProgressBar();
      BaseResponse baseResponse = await notificationRepository.getNotificationList();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        notificationList.clear();
        isNotificationDataFound = true;

        baseResponse.data.forEach((value) {
          Model.Notification notification = Model.Notification.fromJson(value);
          notificationList.add(notification);
        });

      } else {
        isNotificationDataFound = false;
        ToastMessages().showErrorToast(baseResponse.message!);
      }

      hideProgressBar();
    } catch(e) {
      isNotificationDataFound = false;
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
