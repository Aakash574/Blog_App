import 'dart:convert';
import 'dart:developer';

import 'package:blog_app/src/models/blog_model/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class BlogDatabase {
  Future<void> storeBlogs() async {
    final db = FirebaseFirestore.instance;

    try {
      final user = {
        "title": "userModel.email",
        "phoneNo": "userModel.phoneNumber",
        "photoURL": "userModel.photoURL",
        "uid": "userModel.uid",
      };
      db.collection("Blogs").add(user).then((DocumentReference doc) =>
          log('DocumentSnapshot added with ID: ${doc.id}'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<ApiBlogModel>> fatchBlog() async {
    Response response = await http.get(
      Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2023-11-22&sortBy=publishedAt&apiKey=cb186ad2d30d4b0b90a66ab3e5df73a4",
      ),
    );

    final blogData = json.decode(response.body);
    final jsonEncode = json.encode(blogData['articles']);
    return apiBlogModelFromJson(jsonEncode);
  }

  Future<void> getBlogs() async {
    final db = FirebaseFirestore.instance;

    final docRef = db.collection("Blogs").doc("blog");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        log(data.toString());
      },
      onError: (e) => log("Error getting document: $e"),
    );
  }
}
