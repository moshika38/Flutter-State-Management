import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CartProvider cartProvider, child) =>
          Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                  "Total : \$${cartProvider.cartItems.fold(0, (sum, item) => sum + (double.parse(item.price) * item.qty).round())}"),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            cartProvider.clearCart();
          },
          child: const Icon(Icons.clear_all),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: cartProvider.cartItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return ItemCart(
              index: index,
              title: cartProvider.cartItems[index].title,
              des: cartProvider.cartItems[index].dis,
              price: cartProvider.cartItems[index].price,
              qty: cartProvider.cartItems[index].qty.toString(),
            );
          },
        ),
      ),
    );
  }
}

class ItemCart extends StatelessWidget {
  final int index;
  final String title;
  final String des;
  final String price;
  final String qty;

  const ItemCart({
    super.key,
    required this.index,
    required this.title,
    required this.des,
    required this.price,
    required this.qty,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, CartProvider cartProvider, child) => Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Left side - Item details
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      des,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "\$$price",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Qty : $qty",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Right side - Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      cartProvider.removeQty(cartProvider.cartItems[index]);
                    },
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cartProvider
                          .removeFromCart(cartProvider.cartItems[index]);
                    },
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
