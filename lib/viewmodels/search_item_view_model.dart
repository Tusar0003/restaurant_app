
import 'package:pmvvm/view_model.dart';
import 'package:restaurant_app/models/base_response.dart';
import 'package:restaurant_app/models/item.dart';
import 'package:restaurant_app/repositories/home_repository.dart';
import 'package:restaurant_app/repositories/search_item_repository.dart';
import 'package:restaurant_app/utils/constants.dart';
import 'package:restaurant_app/utils/toast_messages.dart';


class SearchItemViewModel extends ViewModel {

  SearchItemRepository searchItemRepository = SearchItemRepository();

  bool isLoading = false;
  bool isClearIconVisible = false;
  String searchString = '';

  List<Item> searchItemList = [];

  @override
  void init() {
    getRecommendedItemList();
  }

  showProgressBar() {
    isLoading = true;
    notifyListeners();
  }

  hideProgressBar() {
    isLoading = false;
    notifyListeners();
  }

  setSearchString(String newVal) {
    if (newVal.isEmpty) {
      isClearIconVisible = false;
    } else {
      isClearIconVisible = true;
    }

    searchString = newVal;
    notifyListeners();
  }

  getRecommendedItemList() async {
    try {
      showProgressBar();

      BaseResponse baseResponse = await HomeRepository().getRecommendedItemList();

      if (baseResponse.isSuccess && baseResponse.data != null) {
        searchItemList.clear();

        baseResponse.data.forEach((value) {
          searchItemList.add(Item.fromJson(value));
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

  getSearchItemList() async {
    try {
      BaseResponse baseResponse = await searchItemRepository.getSearchItemList(searchString);

      if (baseResponse.isSuccess && baseResponse.data != null) {
        searchItemList.clear();

        baseResponse.data.forEach((value) {
          searchItemList.add(Item.fromJson(value));
        });
      }
    } catch(e) {
      ToastMessages().showErrorToast(Constants.EXCEPTION_MESSAGE);
    }

    notifyListeners();
  }
}