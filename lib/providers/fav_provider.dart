import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter/material.dart';

class FavProvider extends ChangeNotifier {
  final List<ItemModel> favItems = [];

  void addOrRemoveFav(ItemModel item) {
    if (favItems.contains(item)) {
      favItems.remove(item);
      notifyListeners();
    } else {
      favItems.add(item);
      notifyListeners();
    }
  }

  bool isFav(ItemModel item) {
    if (favItems.contains(item)) {
      return true;
    } else {
      return false;
    }
  }

  void clearFav() {
    favItems.clear();
    notifyListeners();
  }
}
