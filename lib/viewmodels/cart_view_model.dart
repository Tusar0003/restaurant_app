import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/order.dart';
import 'package:restaurant_app/models/order_type.dart';
import 'package:restaurant_app/models/promo_details.dart';
import 'package:restaurant_app/models/update_cart_item.dart';
import 'package:restaurant_app/repositories/cart_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class CartViewModel extends ViewModel {

  CartRepository cartRepository = CartRepository();

  bool isLoading = false;
  bool isPromoCodeApplied = false;
  String promoCode = '';
  int promoDiscount = 0;
  int orderTypeIndex = 0;
  int deliveryCharge = 0;
  int totalPrice = 0;

  List<CartItem> cartItemList = [];
  List<OrderType> orderTypeList = [];

  @override
  Future<void> init() async {
    showProgressBar();
    await getCartItemList();
    await getOrderTypeList();
    hideProgressBar();
  }

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  setOrderType(bool isSelected, int index) {
    orderTypeIndex = isSelected ? index : 0;
    deliveryCharge = orderTypeList[orderTypeIndex].deliveryCharge!;
    notifyListeners();
  }

  setPromoDetails(PromoDetails promoDetails) {
    promoCode = promoDetails.promoCode!;
    promoDiscount = int.parse(promoDetails.discountAmount!);
    isPromoCodeApplied = true;
    notifyListeners();
  }

  removePromoCode() {
    isPromoCodeApplied = false;
    promoDiscount = 0;
    notifyListeners();
  }

  incrementQuantity(CartItem cartItem) async {
    cartItem.quantity = cartItem.quantity! + 1;
    cartItem.subTotalPrice = cartItem.unitPrice! * cartItem.quantity!;
    totalPrice += cartItem.unitPrice!;
    updateCart(cartItem);
    notifyListeners();
  }

  decrementQuantity(CartItem cartItem) async {
    if (cartItem.quantity! == 1) {
      cartItemList.remove(cartItem);
    }

    cartItem.quantity = cartItem.quantity! - 1;
    cartItem.subTotalPrice = cartItem.unitPrice! * cartItem.quantity!;
    totalPrice -= cartItem.unitPrice!;
    updateCart(cartItem);
    notifyListeners();
  }

  getCartItemList() async {
    try {
      BaseResponse baseResponse = await cartRepository.getCartItemList();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        cartItemList.clear();

        baseResponse.data.forEach((value) {
          CartItem cartItem = CartItem.fromJson(value);
          totalPrice += cartItem.subTotalPrice!;
          cartItemList.add(cartItem);
        });
      } else {
        ToastMessages().showErrorToast(baseResponse.message!);
      }
    } catch(e) {
      hideProgressBar();
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }

  getOrderTypeList() async {
    try {
      BaseResponse baseResponse = await cartRepository.getOrderTypeList();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        orderTypeList.clear();

        baseResponse.data.forEach((value) {
          orderTypeList.add(OrderType.fromJson(value));
        });
      } else {
        ToastMessages().showErrorToast(baseResponse.message!);
      }
    } catch(e) {
      hideProgressBar();
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }

  updateCart(CartItem cartItem) async {
    try {
      showProgressBar();

      Prefs.init();
      UpdateCartItem updateCartItem = UpdateCartItem(
        cartId: cartItem.id.toString(),
        mobileNumber: Prefs.getString(Constants.MOBILE_NUMBER),
        quantity: cartItem.quantity.toString(),
        subTotalPrice: cartItem.subTotalPrice.toString(),
      );

      BaseResponse baseResponse = await cartRepository.updateCart(updateCartItem);

      if (baseResponse.isSuccess) {
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

    if (cartItemList.length == 0) {
      Navigator.pop(context);
    }
  }

  deleteCartItem(CartItem cartItem) async {
    try {
      showProgressBar();

      BaseResponse baseResponse = await cartRepository.deleteCartItem(cartItem.id.toString());

      if (baseResponse.isSuccess) {
        cartItemList.remove(cartItem);
        totalPrice -= cartItem.subTotalPrice!;

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

    if (cartItemList.length == 0) {
      Navigator.pop(context);
    }
  }

  confirmOrder() async {
    try {
      showProgressBar();

      Prefs.init();
      Order order = Order(
        mobileNumber: Prefs.getString(Constants.MOBILE_NUMBER),
        orderType: orderTypeList[orderTypeIndex].orderType,
        deliveryCharge: orderTypeList[orderTypeIndex].deliveryCharge.toString()
      );

      BaseResponse baseResponse = await cartRepository.confirmOrder(order);

      if (baseResponse.isSuccess) {
        ToastMessages().showSuccessToast(baseResponse.message!);
        Navigator.pop(context);
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
}
