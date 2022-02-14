import 'package:pmvvm/pmvvm.dart';
import 'package:prefs/prefs.dart';
import 'package:restaurant_app/models/add_to_cart.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/category.dart';
import 'package:restaurant_app/models/current_order.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/repositories/cart_repository.dart';
import 'package:restaurant_app/repositories/home_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class HomeViewModel extends ViewModel {

  HomeRepository homeRepository = HomeRepository();

  bool isLoading = false;
  bool isRecommendedItemEmpty = true;
  int cartItemNumber = 0;
  int currentOrderNumber = 0;
  int categoryIndex = 0;
  String categoryCode = '';
  String currentOrderNo = '';
  String currentOrderType = '';
  String currentOrderTotalQuantity = '';
  String currentOrderTotalDiscount = '';
  String currentOrderDeliveryCharge = '';
  String currentOrderTotalPrice = '';

  List<Item> recommendedItemList = [];
  List<Category> categoryList = [];
  List<Item> itemList = [];
  List<CurrentOrder> currentOrderList = [];
  List<CurrentOrderItems> currentOrderItemList = [];

  @override
  Future<void> init() async {
    showProgressBar();
    getCartItemNumber();
    getCurrentOrderList();
    await getRecommendedItemList();
    await getCategoryList();
    await getItemList();
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

  setCategory(bool isSelected, int index) {
    categoryIndex = isSelected ? index : 0;
    categoryCode = categoryList[index].categoryCode!;
    getItemList();
    notifyListeners();
  }

  bool hasDiscount(Item item) {
    bool hasDiscount = false;

    if (item.discountAmount == null || item.discountAmount == 0) {
      hasDiscount = false;
    } else {
      hasDiscount = true;
    }

    return hasDiscount;
  }

  int getDiscountPrice(Item item) {
    int discountPrice = 0;

    if (item.discountAmount == null || item.discountAmount == 0) {
      discountPrice = item.price!;
    } else {
      discountPrice = item.price! - item.discountAmount!;
    }

    return discountPrice;
  }

  String getStatus(CurrentOrder currentOrder) {
    String status = '';

    if ((currentOrder.isAccepted == null || currentOrder.isAccepted == 0) &&
        (currentOrder.isCompleted == null || currentOrder.isCompleted == 0)) {
      status = Constants.YOUR_ORDER_IS_PENDING;
    } else if (currentOrder.isAccepted == 0 && currentOrder.isCompleted == 1) {
      status = Constants.REJECTED;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isCompleted == 0) {
      status = Constants.PREPARING_YOUR_FOOD;
    } else if (currentOrder.isAccepted == 1 && currentOrder.isCompleted == 1) {
      status = Constants.COMPLETED_ORDER;
    }

    return status;
  }

  getRecommendedItemList() async {
    try {
      BaseResponse baseResponse = await homeRepository.getRecommendedItemList();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        isRecommendedItemEmpty = false;
        recommendedItemList.clear();

        baseResponse.data.forEach((value) {
          recommendedItemList.add(Item.fromJson(value));
        });
      } else {
        isRecommendedItemEmpty = true;
        ToastMessages().showErrorToast(baseResponse.message!);
      }
    } catch(e) {
      hideProgressBar();
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }

  getCategoryList() async {
    try {
      BaseResponse baseResponse = await homeRepository.getCategoryList();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        categoryList.clear();

        baseResponse.data.forEach((value) {
          categoryList.add(Category.fromJson(value));
        });

        categoryCode = categoryList[0].categoryCode!;
      } else {
        ToastMessages().showErrorToast(baseResponse.message!);
      }
    } catch(e) {
      hideProgressBar();
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }

  getItemList() async {
    try {
      showProgressBar();

      BaseResponse baseResponse = await homeRepository.getItemList(categoryCode);

      if (baseResponse.isSuccess && baseResponse.data != null) {
        itemList.clear();

        baseResponse.data.forEach((value) {
          itemList.add(Item.fromJson(value));
        });
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

  addToCart(Item item) async {
    try {
      showProgressBar();

      String price;
      if (item.discountAmount != null && item.discountAmount != 0) {
        price = (item.price! - item.discountAmount!).toString();
      } else {
        price = item.price.toString();
      }

      Prefs.init();
      AddToCart addToCart = AddToCart(
        mobileNumber: Prefs.getString(Constants.MOBILE_NUMBER),
        quantity: '1',
        itemCode: item.itemCode,
        itemName: item.itemName,
        unitPrice: item.price.toString(),
        discountPercent: item.discountPercent.toString(),
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
      BaseResponse baseResponse = await homeRepository.getCartItemNumber();

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

  getCurrentOrderList() async {
    try {
      BaseResponse baseResponse = await homeRepository.getCurrentOrderList();

      if (baseResponse.isSuccess && baseResponse.data.length > 0) {
        currentOrderNumber = baseResponse.data.length;
        currentOrderList.clear();

        baseResponse.data.forEach((element) {
          currentOrderList.add(CurrentOrder.fromJson(element));
        });
      }
    } catch(e) {
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }
}
