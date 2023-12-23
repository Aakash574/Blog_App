import 'package:blog_app/src/controllers/login_controller.dart';
import 'package:blog_app/src/utils/constants/colors.dart';
import 'package:blog_app/src/utils/constants/size.dart';
import 'package:blog_app/src/views/dashboard/dashboard.dart';
import 'package:blog_app/src/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

enum Pages { dashboard, profilePage }

class BlogApp extends StatefulWidget {
  const BlogApp({super.key});

  @override
  State<BlogApp> createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 96,
        leadingWidth: 0,
        backgroundColor: ConstColors.primaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: Container(
          padding: PADDING32,
          alignment: Alignment.center,
          child: const FaIcon(
            FontAwesomeIcons.bars,
          ),
        ),
        title: Row(
          children: [
            LottieBuilder.network(
              height: 256,
              "https://lottie.host/edff3d85-90ad-4ce5-ba10-c527d8d547ba/nTxVaNsxs7.json",
            ),
            const Spacer(),
            CircleAvatar(
              radius: 24,
              child: GestureDetector(
                onTap: () => Get.to(() => const ProfilePage()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    userController.user.photoURL.toString(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: const Dashboard(),
    );
  }
}
