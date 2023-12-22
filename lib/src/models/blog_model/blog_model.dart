import 'dart:convert';

class BlogModel {
  final String id;
  final String title;
  final String description;
  final String urlToImage;
  final String content;
  final String publishedAt;

  BlogModel(
    this.urlToImage, {
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.publishedAt,
  });
}

// To parse this JSON data, do
//
//     final apiBlogModel = apiBlogModelFromJson(jsonString);
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
