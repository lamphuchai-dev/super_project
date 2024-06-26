// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

import 'package:super_app/models/chapter.dart';
import 'package:super_app/models/genre.dart';
import 'package:super_app/models/track_read.dart';

import '../app/types.dart';
part 'book.g.dart';

@Collection()
@Name("Book")
class Book {
  Id? id;
  String? name;
  String? url;
  String? cover;
  String? author;
  String? description;
  String? status;
  @Enumerated(EnumType.name)
  ExtensionType? type;
  DateTime? updateAt;
  // movie
  String? quality;
  // movie
  String? year;

  @Backlink(to: 'book')
  final chapters = IsarLinks<Chapter>();

  final genres = IsarLinks<Genre>();

  @Backlink(to: 'book')
  final trackRead = IsarLink<TrackRead>();

  Book(
      {this.id = Isar.autoIncrement,
      required this.name,
      required this.url,
      this.author,
      this.cover,
      this.description,
      this.status,
      required this.type,
      this.updateAt,
      this.quality,
      this.year});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'cover': cover,
      'author': author,
      'description': description,
      'status': status,
      'type': type?.name,
      'updateAt': updateAt?.millisecondsSinceEpoch,
      'quality': quality,
      'year': year,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      name: map['name'] ?? "",
      url: map['url'] ?? "",
      cover: map['cover'],
      author: map['author'] != null ? map['author'] as String : null,
      description: map['description']?.toString(),
      status: map['status'] != null ? map['status'] as String : null,
      type: map['type'] != null
          ? map['type'] is ExtensionType
              ? map['type']
              : ExtensionType.values.firstWhere(
                  (element) => element.name == map['type'],
                  orElse: () => ExtensionType.novel,
                )
          : null,
      updateAt: map['updateAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updateAt'] as int)
          : null,
      quality: map['quality'] != null ? map['quality'] as String : null,
      year: map['year'] != null ? map['year'] as String : null,
    );
  }

  factory Book.fromMapToDetail(Map<String, dynamic> map) {
    final book = Book.fromMap(map);
    if (map["genres"] != null) {
      final genres = List<Genre>.from(
        (map['genres']).map<Genre>(
          (x) => Genre.fromMap(x),
        ),
      );
      book.genres.addAll(genres);
    }
    return book;
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) =>
      Book.fromMap(json.decode(source) as Map<String, dynamic>);

  String get getSource {
    final uri = Uri.parse(url!);
    return "${uri.scheme}://${uri.host}";
  }
}
