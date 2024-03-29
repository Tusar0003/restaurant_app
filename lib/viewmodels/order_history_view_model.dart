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
  bool isOrderDataFound = false;
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
        await initOrderHistoryList(OrderHistory.fromJson(baseResponse.data!));
        orderHistoryList.length > 0 ? isOrderDataFound = true : isOrderDataFound = false;
      } else {
        isOrderDataFound = false;
        ToastMessages().showErrorToast(baseResponse.message!);
      }

      hideProgressBar();
    } catch(e) {
      isOrderDataFound = false;
      hideProgressBar();
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }

  initOrderHistoryList(OrderHistory orderHistory) async {
    orderHistoryList.clear();

    orderHistory.pendingData!.forEach((element) async {
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

    orderHistory.confirmedData!.forEach((element) async {
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
          isPrepared: element.isPrepared,
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
        (orderData.isPrepared == null || orderData.isPrepared == 0)) {
      status = Constants.PENDING;
    } else if (orderData.isAccepted == 0 && orderData.isCompleted == 1) {
      status = Constants.REJECTED;
    } else if (orderData.isAccepted == 1 && orderData.isPrepared == 0) {
      status = Constants.ACCEPTED;
    } else if (orderData.isAccepted == 1 && orderData.isPrepared == 1 && orderData.isCompleted == 0) {
      status = Constants.PREPARED;
    } else if (orderData.isAccepted == 1 && orderData.isPrepared == 1 && orderData.isCompleted == 1) {
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
        (orderData.isPrepared == null || orderData.isPrepared == 0)) {
      lottie = 'assets/lotties/waiting.json';
      orderStatus = Constants.YOUR_ORDER_IS_PENDING;
    } else if (orderData.isAccepted == 0 && orderData.isCompleted == 1) {
      lottie = 'assets/lotties/cancelled.json';
      orderStatus = Constants.REJECTED_ORDER;
    } else if (orderData.isAccepted == 1 && orderData.isPrepared == 0) {
      lottie = 'assets/lotties/preparing_food.json';
      orderStatus = Constants.PREPARING_YOUR_FOOD;
    } else if (orderData.isAccepted == 1 && orderData.isPrepared == 1 && orderData.isCompleted == 0) {
      lottie = 'assets/lotties/prepared.json';
      orderStatus = Constants.YOUR_FOOD_IS_READY;
    } else if (orderData.isAccepted == 1 && orderData.isPrepared == 1 && orderData.isCompleted == 1) {
      lottie = 'assets/lotties/completed.json';
      orderStatus = Constants.COMPLETED_ORDER;
    }

    return lottie;
  }
}
