import 'package:flutter/material.dart';

import '../../model/cart_item_model.dart';

class CartButton extends StatefulWidget {
  final CartItemModel product;
  final Function(int qty) onAdd;
  final Function(int qty) onRemove;

  const CartButton(
      {Key? key,
        required this.product,
        required this.onAdd,
        required this.onRemove})
      : super(key: key);

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    int quantity = widget.product.quantity;

    return SizedBox(
      height: 48,
      child: Row(
        children: [
          _iconButton(Icons.remove, () {
            widget.onRemove(quantity - 1);
          }),
          SizedBox(width: 40, child: Center(child: Text("$quantity"))),
          _iconButton(Icons.add, () {
            widget.onAdd(quantity + 1);
          })
        ],
      ),
    );
  }

  Widget _iconButton(IconData iconData, VoidCallback onPressed) => Material(
    shape: const CircleBorder(),
    color: Colors.blue[200],
    child: InkWell(
      splashColor: Colors.white.withOpacity(0.5),
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(iconData),
      ),
    ),
  );
}
