import 'package:pmvvm/pmvvm.dart';


class HomeViewModel extends ViewModel {

  int value = 0;
  int quantity = 0;

  setCategory(bool isSelected, int index) {
    value = isSelected ? index : 0;
    notifyListeners();
  }

  incrementQuantity() {
    quantity += 1;
    notifyListeners();
  }

  decrementQuantity() {
    if (quantity > 0) {
      quantity -= 1;
      notifyListeners();
    }
  }
}