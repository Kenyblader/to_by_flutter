class BuyItem {
  final int? id;
  final String? firestoreId; // ID réel du document Firestore
  final String name;
  final double price;
  final double quantity;
  final DateTime date;
  bool isBuy;

  BuyItem({
    this.id,
    this.firestoreId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.date,
    this.isBuy = false,
  });

  double getTotal() => price * quantity;
}
