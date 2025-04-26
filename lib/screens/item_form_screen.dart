import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_buy/components/style_button.dart';
import 'package:to_buy/models/buy_item.dart';
import 'package:to_buy/provider/theme_provider.dart';
import 'package:to_buy/validators/add_form_validators.dart';

class ItemFormScreen extends StatefulWidget {
  const ItemFormScreen({super.key, BuyItem? item});

  @override
  State<StatefulWidget> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final qteController = TextEditingController();
  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enregistrer votre article"),
        backgroundColor:
            themeProvider.themeData.appBarTheme.backgroundColor ??
            Colors.blueAccent,
        centerTitle: true,
        // titleTextStyle: const TextStyle(
        //   color: Colors.white,
        //   fontWeight: FontWeight.bold,
        //   fontFamily: "Times New Roman",
        //   fontSize: 25,
        // ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            decoration: const BoxDecoration(
              color: Colors.indigoAccent,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(0),
            child: const Icon(
              Icons.arrow_back_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
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
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Ajouter un nouvel article",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Nom",
                      prefixIcon: const Icon(Icons.shopping_cart),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: validateName,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Prix unitaire",
                      prefixIcon: const Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: validatePrice,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: qteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Quantité",
                      prefixIcon: const Icon(Icons.format_list_numbered),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: validateQuantity,
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      labelText: "Date d'expiration",
                      prefixIcon: const Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                        setState(() {
                          dateController.text = formattedDate; // Set the value
                          // Update the text field value with the selected date
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: StyleButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Logique pour enregistrer l'article
                          print("Nom: ${nameController.text}");
                          print("Prix: ${priceController.text}");
                          print("Quantité: ${qteController.text}");
                          print("Date d'expiration: ${dateController.text}");
                        }
                      },
                      backgroundColor: Colors.blueAccent,
                      textColor: Colors.white,
                      borderRadius: 10.0,
                      child: const Text(
                        "Enregistrer",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    qteController.dispose();
    super.dispose();
  }
}
