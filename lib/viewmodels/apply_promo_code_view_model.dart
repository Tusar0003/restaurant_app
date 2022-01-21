import 'package:flutter/cupertino.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/cart_item.dart';
import 'package:restaurant_app/models/confirm_order.dart';
import 'package:restaurant_app/models/order_type.dart';
import 'package:restaurant_app/models/promo_details.dart';
import 'package:restaurant_app/models/update_cart_item.dart';
import 'package:restaurant_app/repositories/cart_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class ApplyPromoCodeViewModel extends ViewModel {

  CartRepository cartRepository = CartRepository();

  bool isLoading = false;
  bool isPromoCodeApplied = false;
  String promoCode = '';
  String promoDiscount = '';

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  setPromoCode(String promoCode) {
    this.promoCode = promoCode;
    notifyListeners();
  }

  applyPromoCode() async {
    try {
      if (promoCode.isEmpty) {
        ToastMessages().showWarningToast('Promo code is empty!');
        return;
      }

      showProgressBar();

      BaseResponse baseResponse = await cartRepository.applyPromoCode(promoCode);

      if (baseResponse.isSuccess) {
        isPromoCodeApplied = true;
        promoDiscount = baseResponse.data.toString();
        ToastMessages().showSuccessToast(baseResponse.message!);

        Navigator.pop(context, PromoDetails(promoCode, promoDiscount));
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
