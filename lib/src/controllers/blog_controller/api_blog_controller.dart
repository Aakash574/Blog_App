import 'package:blog_app/src/models/blog_model/blog_model.dart';
import 'package:blog_app/src/services/blogs/blog_database.dart';
import 'package:get/get.dart';

class ApiBlogController extends GetxController {
  late List<ApiBlogModel> _blog;
  List<ApiBlogModel> get blog => _blog;

  @override
  void onInit() {
    super.onInit();
    _loadBlogFromPrefs();
  }

  Future<void> _loadBlogFromPrefs() async {
    _blog = await BlogDatabase().fatchBlog();
    update();
  }
}
