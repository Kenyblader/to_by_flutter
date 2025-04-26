class BuyList {
  final int? _id;
  String name;
  String description;
  DateTime? expirationDate;

  BuyList(
    this._id, {
    required this.name,
    required this.description,
    this.expirationDate,
  });

  int get id => _id as int;

  factory BuyList.fromJson(Map<String, dynamic> json) {
    return BuyList(
      json['id'] as int?,
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
      'id': _id,
      'expirationDate': expirationDate?.toIso8601String(),
      'description': description,
      'name': name,
    };
  }
}
