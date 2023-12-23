import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<BlogModel> convertQuerySnapshotToBlogModels<T>(
    List<QueryDocumentSnapshot<T>> querySnapshotList) {
  return querySnapshotList.map((QueryDocumentSnapshot<T> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return BlogModel(
      id: snapshot.id,
      author: data['author'] ?? '',
      email: data['email'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['image_url'] ?? '',
      profileUrl: data['profile_url'] ?? '',
      content: data['content'] ?? '',
      publishedAt: data['publishedAt'] ?? DateTime.now().toString(),
    );
  }).toList();
}

class BlogModel {
  final String id;
  final String author;
  final String email;
  final String title;
  final String description;
  final String imageUrl;
  final String profileUrl;
  final String content;
  final String publishedAt;

  BlogModel({
    required this.id,
    required this.author,
    required this.email,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.profileUrl,
    required this.content,
    required this.publishedAt,
  });

  // factory BlogModel.fromJson(Map<String, dynamic> json) {
  //   return BlogModel(
  //     id: json['id'] ?? '',
  //     author: json['author'] ?? '',
  //     email: json['email'] ?? '',
  //     title: json['title'] ?? '',
  //     description: json['description'] ?? '',
  //     imageUrl: json['image_url'] ?? '',
  //     profileUrl: json['profile_url'] ?? '',
  //     content: json['content'] ?? '',
  //     publishedAt: json['publishedAt'] ?? DateTime.now().toString(),
  //   );
  // }
}

List<ApiBlogModel> apiBlogModelFromJson(String str) => List<ApiBlogModel>.from(
    json.decode(str).map((x) => ApiBlogModel.fromJson(x)));

String apiBlogModelToJson(List<ApiBlogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiBlogModel {
  final Source source;
  final dynamic author;
  final String title;
  final dynamic description;
  final String url;
  final dynamic urlToImage;
  final DateTime publishedAt;
  final String content;

  ApiBlogModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ApiBlogModel.fromJson(Map<String, dynamic> json) => ApiBlogModel(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  final dynamic id;
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
