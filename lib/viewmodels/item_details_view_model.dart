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
  int quantity = 1;
  int price = 0;
  int cartItemNumber = 0;

  ItemDetailsViewModel(this.item);

  @override
  void init() {
    price = item.price!;
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

  incrementQuantity() {
    int priceAfterDiscount;
    if (item.discountAmount != null && item.discountAmount != 0) {
      priceAfterDiscount = item.price! - item.discountAmount!;
    } else {
      priceAfterDiscount = item.price!;
    }

    quantity += 1;
    price = priceAfterDiscount * quantity;

    notifyListeners();
  }

  decrementQuantity() {
    int priceAfterDiscount;
    if (item.discountAmount != null && item.discountAmount != 0) {
      priceAfterDiscount = item.price! - item.discountAmount!;
    } else {
      priceAfterDiscount = item.price!;
    }

    if (quantity > 1) {
      quantity -= 1;
      price = priceAfterDiscount * quantity;
      notifyListeners();
    }
  }

  addToCart() async {
    try {
      showProgressBar();

      int priceAfterDiscount;
      if (item.discountAmount != null && item.discountAmount != 0) {
        priceAfterDiscount = item.price! - item.discountAmount!;
      } else {
        priceAfterDiscount = item.price!;
      }

      Prefs.init();
      AddToCart addToCart = AddToCart(
        mobileNumber: '+8801521234567',
        quantity: quantity.toString(),
        itemCode: item.itemCode,
        itemName: item.itemName,
        unitPrice: item.price.toString(),
        discountPrice: priceAfterDiscount.toString(),
        subTotalPrice: price.toString(),
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
