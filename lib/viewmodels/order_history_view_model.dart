import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/add_to_cart.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/models/order_history.dart';
import 'package:restaurant_app/repositories/cart_repository.dart';
import 'package:restaurant_app/repositories/home_repository.dart';
import 'package:restaurant_app/repositories/order_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class OrderHistoryViewModel extends ViewModel {

  bool isLoading = false;
  String orderStatus = '';

  late OrderData orderData;
  List<OrderData> orderHistoryList = [];

  @override
  void init() {
    getOrderList();
  }

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  getOrderList() async {
    try {
      showProgressBar();

      BaseResponse baseResponse = await OrderRepository().getOrderList();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        initOrderHistoryList(OrderHistory.fromJson(baseResponse.data!));
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

  initOrderHistoryList(OrderHistory orderHistory) {
    orderHistory.pendingData!.forEach((element) {
      orderHistoryList.add(
        OrderData(
          orderNo: element.orderNo,
          mobileNumber: element.mobileNumber,
          totalQuantity: element.totalQuantity,
          totalPrice: element.totalPrice,
          isPromoCodeApplied: element.isPromoCodeApplied,
          promoCode: element.promoCode,
          totalDiscountAmount: element.totalDiscountAmount,
          orderType: element.orderType,
          deliveryCharge: element.deliveryCharge,
          createdBy: element.createdBy,
          createdTime: element.createdTime,
          updatedBy: element.updatedBy,
          updatedTime: element.updatedTime,
          items: element.items
        )
      );
    });

    orderHistory.confirmedData!.forEach((element) {
      orderHistoryList.add(
        OrderData(
          orderNo: element.orderNo,
          mobileNumber: element.mobileNumber,
          totalQuantity: element.totalQuantity,
          totalPrice: element.totalPrice,
          isPromoCodeApplied: element.isPromoCodeApplied,
          promoCode: element.promoCode,
          totalDiscountAmount: element.totalDiscountAmount,
          orderType: element.orderType,
          deliveryCharge: element.deliveryCharge,
          isAccepted: element.isAccepted,
          isCompleted: element.isCompleted,
          createdBy: element.createdBy,
          createdTime: element.createdTime,
          updatedBy: element.updatedBy,
          updatedTime: element.updatedTime,
          items: element.items
        )
      );
    });
  }

  String getOrderStatus(OrderData orderData) {
    String status = '';

    if ((orderData.isAccepted == null || orderData.isAccepted == 0) &&
        (orderData.isCompleted == null || orderData.isCompleted == 0)) {
      status = Constants.PENDING;
    } else if (orderData.isAccepted == 0 && orderData.isCompleted == 1) {
      status = Constants.REJECTED;
    } else if (orderData.isAccepted == 1 && orderData.isCompleted == 0) {
      status = Constants.ACCEPTED;
    } else if (orderData.isAccepted == 1 && orderData.isCompleted == 1) {
      status = Constants.COMPLETED;
    }

    return status;
  }

  setOrderData(OrderData orderData) async {
    this.orderData = orderData;
    notifyListeners();
  }

  String getLottie() {
    String lottie = '';

    if ((orderData.isAccepted == null || orderData.isAccepted == 0) &&
        (orderData.isCompleted == null || orderData.isCompleted == 0)) {
      lottie = 'assets/lotties/waiting.json';
      orderStatus = Constants.YOUR_ORDER_IS_PENDING;
    } else if (orderData.isAccepted == 0 && orderData.isCompleted == 1) {
      lottie = 'assets/lotties/completed.json';
      orderStatus = Constants.REJECTED_ORDER;
    } else if (orderData.isAccepted == 1 && orderData.isCompleted == 0) {
      lottie = 'assets/lotties/preparing_food.json';
      orderStatus = Constants.PREPARING_YOUR_FOOD;
    } else if (orderData.isAccepted == 1 && orderData.isCompleted == 1) {
      lottie = 'assets/lotties/completed.json';
      orderStatus = Constants.COMPLETED_ORDER;
    }

    return lottie;
  }
}
