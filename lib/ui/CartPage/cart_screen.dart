import 'package:flutter/material.dart';
import 'package:anglara_ecommerce/repository/cart_repository.dart';

import '../../model/cart_item_model.dart';
import 'cart_button_widget.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback? onItemRemoved;

  const CartScreen({Key? key, this.onItemRemoved}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<List<CartItemModel>> _cartItemsFuture;

  @override
  void initState() {
    super.initState();
    _cartItemsFuture = CartRepository().getCartItems();
  }

  void incrementQuantity(CartItemModel cartItem) async {
    await CartRepository()
        .updateCartItem(cartItem.product, cartItem.quantity + 1);
    _cartItemsFuture = CartRepository().getCartItems();
    setState(() {});
  }

  void decrementQuantity(CartItemModel cartItem, int index) async {
    final newQuantity = cartItem.quantity - 1;
    if (newQuantity < 1) {
      removeDialog(index, _cartItemsFuture);
    } else {
      await CartRepository().updateCartItem(cartItem.product, newQuantity);
    }
    _cartItemsFuture = CartRepository().getCartItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CartItemModel>>(
        future: _cartItemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to fetch cart items'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cartItem = snapshot.data![index];
                return Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: .1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Center(
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: Image.network(
                            cartItem.product.image!,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                cartItem.product.title!,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 10),
                              Text("\$${cartItem.product.price}"),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Expanded(child: Text("Quantity")),
                                  CartButton(
                                    product: cartItem,
                                    onAdd: (qty) {
                                      incrementQuantity(cartItem);
                                      setState(() {});
                                    },
                                    onRemove: (qty) {
                                      decrementQuantity(cartItem, index);
                                      setState(() {});
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future removeDialog(int index, Future<List<CartItemModel>> cartItemsFuture) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Remove Item"),
          content: const Text("Are you sure you want to remove this item?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  CartRepository().removeFromCart(index);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        const Text('Successfully removed item from your cart'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ));
                  widget.onItemRemoved!();
                  _cartItemsFuture = CartRepository().getCartItems();
                },
                child: const Text("Yes"))
          ],
        );
      },
    );
  }
}
