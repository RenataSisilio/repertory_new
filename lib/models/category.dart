import 'dart:convert';

class Category {
  final String name;
  final List<String> subcats;

  Category({
    required this.name,
    required this.subcats,
  });

  Category copyWith({
    String? name,
    List<String>? subcats,
  }) {
    return Category(
      name: name ?? this.name,
      subcats: subcats ?? this.subcats,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'subcats': subcats,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'] as String,
      subcats: (map['subcats'] as List).map((e) => e.toString()).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
