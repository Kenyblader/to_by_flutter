import 'package:flutter/material.dart';
import 'package:to_buy/models/buy_item.dart';

class ItemList extends StatelessWidget {
  final BuyItem item;

  const ItemList({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Text('Prix: ${item.price} €'),
      trailing: Text('Quantité: ${item.quantity}'),
      onTap: () {},
    );
  }
}
