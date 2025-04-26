import 'package:to_buy/models/buy_item.dart';

class BuyList {
  final int? id;
  String name;
  String description;
  List<BuyItem> items = [];
  DateTime? expirationDate;

  BuyList({
    this.id,
    required this.name,
    required this.description,
    this.expirationDate,
    List<BuyItem>? items,
  }) {
    this.items = items ?? [];
  }

  factory BuyList.fromJson(Map<String, dynamic> json) {
    return BuyList(
      id: json['id'] as int?,
      name: json['name'] as String,
      description: json['description'] as String,
      expirationDate:
          json['expirationDate'] != null
              ? DateTime.parse(json['expirationDate'])
              : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'expirationDate': expirationDate?.toIso8601String(),
      'description': description,
      'name': name,
    };
  }
}
