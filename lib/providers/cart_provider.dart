import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/cart_model.dart';
import 'package:flutter_application_1/models/item_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> cartItems = [];
  int addedQty = 1;
  void addToCart(ItemModel item) {
    if (isCart(item)) {
      var index =
          cartItems.indexWhere((element) => element.title == item.title);
      var cartItem = cartItems[index];
      cartItems[index] = CartModel(
          title: cartItem.title,
          dis: cartItem.dis,
          price: cartItem.price,
          qty: cartItem.qty + 1);
      addedQty = cartItems[index].qty;
    } else {
      cartItems.add(CartModel(
          title: item.title, dis: item.des, price: item.price, qty: 1));
      addedQty = 1;
    }
    notifyListeners();
  }

  bool isCart(ItemModel item) {
    return cartItems.any((cartItem) => cartItem.title == item.title);
  }

  void removeQty(CartModel cartItem) {
    var index =
        cartItems.indexWhere((element) => element.title == cartItem.title);
    cartItems[index] = CartModel(
      title: cartItem.title,
      dis: cartItem.dis,
      price: cartItem.price,
      qty: cartItem.qty != 1 ? cartItem.qty - 1 : 1,
    );

    notifyListeners();
  }

  void removeFromCart(CartModel cartItem) {
    cartItems.remove(cartItem);
    notifyListeners();
  }

  void clearCart() {
    cartItems.clear();
    notifyListeners();
  }
}
