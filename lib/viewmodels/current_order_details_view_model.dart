import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/add_to_cart.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/current_order.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/repositories/cart_repository.dart';
import 'package:restaurant_app/repositories/home_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class CurrentOrderDetailsViewModel extends ViewModel {

  bool isLoading = false;
  String orderStatus = '';
  CurrentOrder currentOrder;

  CurrentOrderDetailsViewModel(this.currentOrder);

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  String getLottie() {
    String lottie = '';

    if ((currentOrder.isAccepted == null || currentOrder.isAccepted == 0) &&
        (currentOrder.isPrepared == null || currentOrder.isPrepared == 0)) {
      lottie = 'assets/lotties/waiting.json';
      orderStatus = Constants.YOUR_ORDER_IS_PENDING;
    } else if (currentOrder.isAccepted == 0 && currentOrder.isCompleted == 1) {
      lottie = 'assets/lotties/cancelled.json';
      orderStatus = Constants.REJECTED_ORDER;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isPrepared == 0) {
      lottie = 'assets/lotties/preparing_food.json';
      orderStatus = Constants.PREPARING_YOUR_FOOD;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isPrepared == 1 && currentOrder.isCompleted == 0) {
      lottie = 'assets/lotties/prepared.json';
      orderStatus = Constants.YOUR_FOOD_IS_READY;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isPrepared == 1 && currentOrder.isCompleted == 1) {
      lottie = 'assets/lotties/completed.json';
      orderStatus = Constants.COMPLETED_ORDER;
    }

    return lottie;
  }

  String getOrderStatus() {
    String status = '';

    if ((currentOrder.isAccepted == null || currentOrder.isAccepted == 0) &&
        (currentOrder.isPrepared == null || currentOrder.isPrepared == 0)) {
      status = Constants.PENDING;
    } else if (currentOrder.isAccepted == 0 && currentOrder.isCompleted == 1) {
      status = Constants.REJECTED;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isPrepared == 0) {
      status = Constants.ACCEPTED;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isPrepared == 1 && currentOrder.isCompleted == 0) {
      status = Constants.PREPARED;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isPrepared == 1 && currentOrder.isCompleted == 1) {
      status = Constants.COMPLETED;
    }

    return status;
  }
}
