import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/add_to_cart.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/repositories/cart_repository.dart';
import 'package:restaurant_app/repositories/home_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class ItemDetailsViewModel extends ViewModel {

  bool isLoading = false;

  Item item;
  bool hasDiscount = false;
  int quantity = 1;
  int price = 0;
  int discountPrice = 0;
  int cartItemNumber = 0;

  ItemDetailsViewModel(this.item);

  @override
  void init() {
    checkDiscount();
    getCartItemNumber();
  }

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  checkDiscount() {
    price = item.price!;

    if (item.discountPercent == null || item.discountPercent == 0) {
      hasDiscount = false;
      discountPrice = item.price!;
    } else {
      hasDiscount = true;
      discountPrice = item.price! - item.discountAmount!;
    }

    notifyListeners();
  }

  incrementQuantity() {
    quantity += 1;
    price = item.price! * quantity;
    double discountAmount = (item.price! * quantity * item.discountPercent!) / 100;
    double priceAfterDiscount = price - discountAmount;
    discountPrice = priceAfterDiscount.round();

    notifyListeners();
  }

  decrementQuantity() {
    if (quantity > 1) {
      quantity -= 1;
      price = item.price! * quantity;
      double discountAmount = (item.price! * quantity * item.discountPercent!) / 100;
      double priceAfterDiscount = price - discountAmount;
      discountPrice = priceAfterDiscount.round();
      notifyListeners();
    }
  }

  addToCart() async {
    try {
      showProgressBar();

      Prefs.init();
      AddToCart addToCart = AddToCart(
        mobileNumber: Prefs.getString(Constants.MOBILE_NUMBER),
        quantity: quantity.toString(),
        itemCode: item.itemCode,
        itemName: item.itemName,
        unitPrice: item.price.toString(),
        discountPercent: item.discountPercent.toString(),
        subTotalPrice: discountPrice.toString(),
      );

      BaseResponse baseResponse = await CartRepository().addToCart(addToCart);

      if (baseResponse.isSuccess) {
        getCartItemNumber();
        ToastMessages().showSuccessToast(baseResponse.message!);
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

  getCartItemNumber() async {
    try {
      BaseResponse baseResponse = await HomeRepository().getCartItemNumber();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        cartItemNumber = baseResponse.data;
      } else {
        ToastMessages().showErrorToast(baseResponse.message!);
      }
    } catch(e) {
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }
}
