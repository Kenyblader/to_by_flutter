import 'package:to_buy/models/buy_item.dart';

class BuyList {
  final int? id;
  String name;
  String? description;
  List<BuyItem> items = [];
  DateTime date;

  BuyList({
    this.id,
    required this.name,
    this.description,
    DateTime? date,
    List<BuyItem>? items,
  }) : date = date ?? DateTime.now() {
    this.items = items ?? [];
  }

  factory BuyList.fromJson(Map<String, dynamic> json) {
    return BuyList(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date?.toIso8601String(),
      'description': description,
      'name': name,
    };
  }
}
