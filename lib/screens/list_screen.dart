import 'package:flutter/material.dart';
import 'package:to_buy/models/buy_list.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _searchController = TextEditingController();
  final List<BuyList> _filteredItems = [];
  List<BuyList> items = [
    BuyList(name: 'Liste 1', description: "Liste 1"),
    BuyList(name: 'Liste 2', description: "Liste 2"),
    BuyList(name: 'Liste 3', description: "Liste 3"),
    BuyList(name: 'Liste 4', description: "Liste 4"),
    BuyList(name: 'Liste 5', description: "Liste 5"),
    BuyList(name: 'Liste 6', description: "Liste 6"),
    BuyList(name: 'Liste 7', description: "Liste 7"),
    BuyList(name: 'Liste 8', description: "Liste 8"),
  ];
  void filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems.clear();
        _filteredItems.addAll(items);
      } else {
        _filteredItems.clear();
        _filteredItems.addAll(
          items.where(
            (item) => item.name.toLowerCase().contains(query.toLowerCase()),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _filteredItems.addAll(items); // Initialize filtered items with all items
    return Scaffold(
      appBar: AppBar(
        title: Text("Mes Listes"),
        backgroundColor: Colors.blueAccent,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.bolt))],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                filterItems(value);
              },
              decoration: InputDecoration(
                labelText: 'Rechercher une liste',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredItems[index].name),
                    subtitle: Text(_filteredItems[index].description ?? ""),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          items.removeAt(index);
                          _filteredItems.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
