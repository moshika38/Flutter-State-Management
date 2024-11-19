import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/item_data.dart';
import 'package:flutter_application_1/models/item_model.dart';
import 'package:flutter_application_1/providers/cart_provider.dart';
import 'package:flutter_application_1/providers/fav_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ItemModel> items = ItemData.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'favorite_fab',
            onPressed: () {
              context.pushNamed('fav');
            },
            child: const Icon(Icons.favorite),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: 'cart_fab',
            onPressed: () {
              context.pushNamed('cart');
            },
            child: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ItemCart(
            currentItemModel: items[index],
            index: index,
            title: items[index].title,
            des: items[index].des,
            price: items[index].price,
          );
        },
      ),
    );
  }
}

class ItemCart extends StatelessWidget {
  final int index;
  final String title;
  final String des;
  final String price;
  final ItemModel currentItemModel;
  const ItemCart({
    super.key,
    required this.index,
    required this.title,
    required this.des,
    required this.price,
    required this.currentItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2(builder: (BuildContext context, FavProvider favProvider,
        CartProvider cartProvider, child) {
      return Card(
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
                  ],
                ),
              ),
              // Right side - Buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      favProvider.isFav(currentItemModel)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favProvider.isFav(currentItemModel)
                          ? Colors.red
                          : Colors.white,
                    ),
                    onPressed: () {
                      favProvider.addOrRemoveFav(currentItemModel);
                    },
                    iconSize: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: cartProvider.isCart(currentItemModel)
                          ? Colors.green
                          : Colors.white,
                    ),
                    onPressed: () {
                      cartProvider.addToCart(currentItemModel);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Added to cart qty : ${cartProvider.addedQty}",
                          ),
                        ),
                      );
                    },
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
