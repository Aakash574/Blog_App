import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:blog_app/src/controllers/blog_controller/firebase_blog_controller.dart';
import 'package:blog_app/src/controllers/login_controller.dart';
import 'package:blog_app/src/models/blog_model/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BlogDatabase {
  final UserController userController = getx.Get.find();
  Future<bool> storeBlogs(
    title,
    description,
    content,
    imageUrl,
  ) async {
    final db = FirebaseFirestore.instance;

    try {
      final user = {
        "id": math.Random().nextInt(100) + 99999,
        "author": userController.user.displayName,
        "email": userController.user.email,
        "profile_url": userController.user.photoURL,
        "title": title,
        "description": description,
        "content": content,
        "image_url": imageUrl,
        "publishedAt": DateTime.now().toString(),
      };
      BlogController blogController = getx.Get.find();
      blogController.loadBlogFromPrefs();

      db.collection("Blogs").add(user).then((DocumentReference doc) =>
          log('DocumentSnapshot added with ID: ${doc.id}'));

      return true;
    } catch (e) {
      log(e.toString());
      return false;
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

  Future<List<BlogModel>> getBlogs() async {
    final db = FirebaseFirestore.instance;

    Future<QuerySnapshot<Map<String, dynamic>>> snapshot =
        db.collection("Blogs").get();
    late List<BlogModel> blog;

    await snapshot.then((value) {
      blog = convertQuerySnapshotToBlogModels(value.docs);
    });
    return blog;
  }
}
