import 'package:flutter/material.dart';
import 'package:to_buy/components/nav_card.dart';
import 'package:to_buy/models/buy_list.dart';
import 'package:to_buy/screens/item_form_screen.dart';
import 'package:to_buy/screens/item_list_screen.dart';
import 'package:to_buy/screens/list_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListiFy'),
        centerTitle: true,
        titleSpacing: 10,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        leading: const Icon(Icons.list),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(5),
              child: Icon(
                Icons.logout_rounded,
                color: const Color.fromARGB(255, 253, 252, 252),
              ),
            ),
          ),
        ],
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NavCard(
              title: "Nouvelle Liste",
              icon: Icons.newspaper_rounded,
              destination: const ListFormScreen(),
            ),
            NavCard(
              title: "Mes Listes",
              icon: Icons.article_rounded,
              destination: ItemListScreen(
                list: BuyList(
                  name: "Achat lunch dimanche",
                  description: "description",
                ),
              ),
            ),
            NavCard(
              title: "Nouvel Article",
              icon: Icons.add_circle_rounded,
              destination: const ItemFormScreen(),
            ),
            NavCard(
              title: "Mes Articles",
              icon: Icons.add_shopping_cart_sharp,
              destination: ItemListScreen(
                list: BuyList(
                  name: "Achat lunch dimanche",
                  description: "description",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
