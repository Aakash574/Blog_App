import 'dart:developer';

import 'package:blog_app/src/models/blog_model/blog_model.dart';
import 'package:blog_app/src/services/blogs/blog_database.dart';
import 'package:get/get.dart';

class BlogController extends GetxController {
  late List<BlogModel> _blog;
  List<BlogModel> get blog => _blog;

  @override
  void onInit() {
    super.onInit();
    loadBlogFromPrefs();
  }

  Future<void> loadBlogFromPrefs() async {
    _blog = await BlogDatabase().getBlogs();
    update();
  }
}
