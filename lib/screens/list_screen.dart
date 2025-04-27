import 'package:flutter/material.dart';
import 'package:to_buy/models/buy_list.dart';
import 'package:to_buy/screens/list_detail_screen.dart';
import 'package:to_buy/services/firestore_service.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _searchController = TextEditingController();
  final List<BuyList> _filteredItems = [];
  final List<BuyList> items = [];
  final fireSoreService = FirestoreService();
  bool isLoading = true;
  bool isCharging = false; // Assuming you have a FirebaseService class
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
  void initState() {
    super.initState();
    var list = fireSoreService.getBuyLists();
    list.listen((event) {
      setState(() {
        items.clear();
        items.addAll(event);
      });
    }); // Initialize filtered items with all items
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    _filteredItems.clear();
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
              onChanged: filterItems,
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
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => ListDetailScreen(
                                  listId: _filteredItems[index].id!,
                                ),
                          ),
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
