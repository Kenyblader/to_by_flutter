import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_buy/components/item_list.dart';
import 'package:to_buy/models/buy_item.dart';
import 'package:to_buy/models/buy_list.dart';
import 'package:to_buy/provider/theme_provider.dart';
import 'package:to_buy/screens/item_form_screen.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key, required this.list});
  final BuyList? list;
  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<BuyItem> items = [
    BuyItem(name: 'Article 1', price: 10.0, quantity: 1, date: DateTime.now()),
    BuyItem(name: 'Article 2', price: 20.0, quantity: 2, date: DateTime.now()),
    BuyItem(name: 'Article 3', price: 30.0, quantity: 3, date: DateTime.now()),
    BuyItem(name: 'Article 4', price: 40.0, quantity: 4, date: DateTime.now()),
    BuyItem(name: 'Article 5', price: 50.0, quantity: 5, date: DateTime.now()),
    BuyItem(name: 'Article 1', price: 10.0, quantity: 1, date: DateTime.now()),
    BuyItem(name: 'Article 2', price: 20.0, quantity: 2, date: DateTime.now()),
    BuyItem(name: 'Article 3', price: 30.0, quantity: 3, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            themeProvider.themeData.appBarTheme.backgroundColor ??
            Colors.blueAccent,
        title: Text(widget.list?.name ?? 'Liste d\'achats'),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: Icon(
              themeProvider.isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.border_left_rounded),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            color: Colors.white,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemList(item: items[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemFormScreen()),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
