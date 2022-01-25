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


class OrderDetailsViewModel extends ViewModel {

  bool isLoading = false;
  String orderStatus = '';
  CurrentOrder currentOrder;

  OrderDetailsViewModel(this.currentOrder);

  @override
  void init() {

  }

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

    if (currentOrder.isAccepted == null || currentOrder.isAccepted == 0) {
      lottie = 'assets/lotties/waiting.json';
      orderStatus = Constants.YOUR_ORDER_IS_PENDING;
    } else {
      if (currentOrder.isAccepted == 1 && (currentOrder.isCompleted == null || currentOrder.isCompleted == 0)) {
        lottie = 'assets/lotties/preparing_food.json';
        orderStatus = Constants.PREPARING_YOUR_FOOD;
      } else if (currentOrder.isAccepted == 1 && currentOrder.isCompleted == 1) {
        lottie = 'assets/lotties/completed.json';
        orderStatus = Constants.COMPLETED_ORDER;
      }
    }

    return lottie;
  }
}
