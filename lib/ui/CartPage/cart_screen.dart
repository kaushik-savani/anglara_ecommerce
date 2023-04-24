import 'package:flutter/material.dart';
import 'package:anglara_ecommerce/repository/cart_repository.dart';
import '../../model/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductModel>>(
        future: CartRepository().getCartItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("Your cart is empty"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final cartItems = snapshot.data![index];
                  return ListTile(
                    leading: Image.network(cartItems.image!),
                    title: Text(cartItems.title!),
                    subtitle: Text('\$${cartItems.price!.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        CartRepository().removeFromCart(index);
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
