class BuyItem {
  final int? id;
  String name;
  double quantity;
  double price;
  DateTime date;
  bool isBuy = false;

  BuyItem({
    this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.date,
  });

  double getTotal() => price * quantity;
}
