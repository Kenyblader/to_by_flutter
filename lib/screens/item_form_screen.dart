import 'package:flutter/material.dart';
import 'package:to_buy/components/style_button.dart';
import 'package:to_buy/models/buy_item.dart';
import 'package:to_buy/models/buy_list.dart';
import 'package:to_buy/services/firestore_service.dart';
import 'package:to_buy/validators/add_form_validators.dart';
import 'package:provider/provider.dart';
import 'package:to_buy/provider/theme_provider.dart';

class ItemFormScreen extends StatefulWidget {
  final BuyItem? item;
  const ItemFormScreen({super.key, this.item});

  @override
  State<ItemFormScreen> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<Map<String, TextEditingController>> _items = [];
  double _total = 0.0;

  @override
  void initState() {
    super.initState();
    _addItemRow();
  }

  void _addItemRow() {
    setState(() {
      _items.add({
        'name': TextEditingController(),
        'price': TextEditingController(),
        'quantity': TextEditingController(),
      });
    });
  }

  void _calculateTotal() {
    double total = 0.0;
    for (var item in _items) {
      final price = double.tryParse(item['price']!.text) ?? 0.0;
      final quantity = double.tryParse(item['quantity']!.text) ?? 0.0;
      total += price * quantity;
    }
    setState(() {
      _total = total;
    });
  }

  void _validateAndSave() async {
    if (_formKey.currentState!.validate()) {
      final items =
          _items
              .map(
                (item) => BuyItem(
                  name: item['name']!.text,
                  price: double.parse(item['price']!.text),
                  quantity: double.parse(item['quantity']!.text),
                  date: DateTime.now(),
                ),
              )
              .toList();

      final buyList = BuyList(
        id: null,
        name: _nameController.text,
        description: _descriptionController.text,
        items: items,
      );

      try {
        await FirestoreService().addBuyList(buyList, items);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Liste créée !')));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur : $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une liste de courses'),
        backgroundColor:
            themeProvider.themeData.appBarTheme.backgroundColor ??
            Colors.blueAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.home, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nom de la liste',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: validateName,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: validateDescription,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Articles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ..._items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controllers = entry.value;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: controllers['name'],
                              decoration: InputDecoration(
                                labelText: 'Nom',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: validateName,
                              onChanged: (_) => _calculateTotal(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: controllers['price'],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Prix',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: validatePrice,
                              onChanged: (_) => _calculateTotal(),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: controllers['quantity'],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Qté',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: validateQuantity,
                              onChanged: (_) => _calculateTotal(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.blue),
                    onPressed: _addItemRow,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Total: ${_total.toStringAsFixed(2)} €',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: StyleButton(
                    onPressed: _validateAndSave,
                    child: const Text('Valider la liste'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    for (var item in _items) {
      item['name']!.dispose();
      item['price']!.dispose();
      item['quantity']!.dispose();
    }
    super.dispose();
  }
}
