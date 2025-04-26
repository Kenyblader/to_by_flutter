import 'package:flutter/material.dart';

class ListFormScreen extends StatefulWidget {
  const ListFormScreen({super.key});

  @override
  _ListFormScreenState createState() => _ListFormScreenState();
}

// This screen will serve as a form for creating a BuyList
class _ListFormScreenState extends State<ListFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _listNameController = TextEditingController();
  final List<TextEditingController> _itemControllers = [];

  void _addItemField() {
    setState(() {
      _itemControllers.add(TextEditingController());
    });
  }

  void _removeItemField(int index) {
    setState(() {
      _itemControllers.removeAt(index);
    });
  }

  void _saveList() {
    if (_formKey.currentState!.validate()) {
      final listName = _listNameController.text;
      final items =
          _itemControllers.map((controller) => controller.text).toList();

      // Logique pour sauvegarder la liste et les articles
      print('Liste: $listName');
      print('Articles: $items');

      // Réinitialiser le formulaire
      _listNameController.clear();
      _itemControllers.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nouvelle Liste')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _listNameController,
                  decoration: InputDecoration(
                    labelText: 'Nom de la liste',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un nom pour la liste';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Text(
                  'Articles',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ..._itemControllers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final controller = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              labelText: 'Article ${index + 1}',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un nom pour l\'article';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => _removeItemField(index),
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _addItemField,
                  icon: Icon(Icons.add),
                  label: Text('Ajouter un article'),
                ),
                SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveList,
                    child: Text('Enregistrer la liste'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
