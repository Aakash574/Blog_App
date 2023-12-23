import 'dart:developer';

import 'package:blog_app/src/controllers/blog_controller/api_blog_controller.dart';
import 'package:blog_app/src/controllers/blog_controller/firebase_blog_controller.dart';
import 'package:blog_app/src/controllers/login_controller.dart';
import 'package:blog_app/src/services/blogs/blog_database.dart';
import 'package:blog_app/src/utils/constants/size.dart';
import 'package:blog_app/src/views/dashboard/widgets/dashboard_widget.dart';
import 'package:blog_app/src/views/profile/add_blog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserController userController = Get.find();
  BlogController blogController = Get.find();
  ApiBlogController api = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: PADDING16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: const FaIcon(
                  FontAwesomeIcons.angleLeft,
                ),
              ),
              SIZEHEIGHT16,
              Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        userController.user.photoURL.toString(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        userController.user.displayName!,
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.titleLarge!.copyWith(),
                      ),
                      subtitle: Text(
                        userController.user.email!,
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.titleSmall!.copyWith(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => userController.signOut(),
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowRightFromBracket,
                    ),
                  ),
                ],
              ),
              SIZEHEIGHT16,
              Text(
                "Your Blogs",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              ),
              SIZEHEIGHT10,
              ListView.builder(
                shrinkWrap: true,
                itemCount: blogController.blog.length,
                itemBuilder: (BuildContext context, int index) {
                  return FireBaseBlogCard(
                    blog: blogController.blog[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddBlogs()),
        // onPressed: (),
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
