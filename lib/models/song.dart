import 'dart:convert';

class Song {
  final String? id;
  final String title;
  final List<String> categories;
  final String? lyricsURL;
  final String? chordsURL;
  final bool favorite;

  Song({
    this.id,
    required this.title,
    required this.categories,
    this.lyricsURL,
    this.chordsURL,
    this.favorite = false,
  });

  Song copyWith({
    String? id,
    String? title,
    List<String>? categories,
    String? lyricsURL,
    String? chordsURL,
    bool? favorite,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      categories: categories ?? this.categories,
      lyricsURL: lyricsURL ?? this.lyricsURL,
      chordsURL: chordsURL ?? this.chordsURL,
      favorite: favorite ?? this.favorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'categories': categories,
      'lyricsURL': lyricsURL,
      'chordsURL': chordsURL,
      'favorite': favorite,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      categories: (map['categories'] as List).map((e) => e.toString()).toList(),
      lyricsURL: map['lyricsURL'] != null ? map['lyricsURL'] as String : null,
      chordsURL: map['chordsURL'] != null ? map['chordsURL'] as String : null,
      favorite: map['favorite'] as bool? ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) =>
      Song.fromMap(json.decode(source) as Map<String, dynamic>);
}
