import 'package:blog_app/src/controllers/blog_controller/api_blog_controller.dart';
import 'package:blog_app/src/controllers/login_controller.dart';
import 'package:blog_app/src/services/blogs/blog_database.dart';
import 'package:blog_app/src/utils/constants/colors.dart';
import 'package:blog_app/src/utils/constants/size.dart';
import 'package:blog_app/src/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'widgets/dashboard_widget.dart';

enum Pages { dashboard, profilePage }

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isActive = false;
  int selectedIndex = 0;
  final UserController userController = Get.find();
  final ApiBlogController apiBlogController = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
     
      body: SafeArea(
        child: SingleChildScrollView(
          padding: PADDING24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey, ${userController.user.displayName.toString()}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Discover Latest News",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SIZEHEIGHT20,
              Row(
                children: [
                  const Expanded(child: SearchBar()),
                  SIZEWIDTH16,
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                      ),
                    ),
                  )
                ],
              ),
              SIZEHEIGHT20,
              Container(
                width: size.width,
                height: 96,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  itemExtent: 86,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    List<IconData> icon = [
                      FontAwesomeIcons.speakerDeck,
                      FontAwesomeIcons.mobile,
                      FontAwesomeIcons.shoePrints,
                      FontAwesomeIcons.khanda,
                    ];
                    List<String> title = [
                      "Podcast",
                      "Mobile",
                      "Shoe",
                      "Khanda",
                    ];
                    return Genres(
                      icon: icon[index],
                      title: title[index],
                      onPressed: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      isActive: selectedIndex == index ? true : false,
                    );
                  },
                ),
              ),
              SIZEHEIGHT20,
              Text(
                "Recommend",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => BlogCard(
                  blog: apiBlogController.blog[index],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await BlogDatabase().fatchBlog(),
      ),
    );
  }
}
