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
    return currentOrder.isAccepted == 1 ?
        'assets/lotties/preparing_food.json' :
        'assets/lotties/waiting.json';
  }

  String getOrderStatus() {
    return currentOrder.isAccepted == 1 ?
        Constants.PREPARING_YOUR_FOOD :
        Constants.YOUR_ORDER_IS_PENDING;
  }
}
