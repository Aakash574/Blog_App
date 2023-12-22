import 'package:blog_app/src/models/blog_model/blog_model.dart';
import 'package:blog_app/src/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Genres extends StatefulWidget {
  final IconData icon;
  final String title;
  final Function() onPressed;
  final bool isActive;
  const Genres({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    required this.isActive,
  });

  @override
  State<Genres> createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: widget.isActive ? Colors.red.shade100 : Colors.grey[50],
          ),
          child: IconButton(
            onPressed: widget.onPressed,
            icon: FaIcon(
              widget.icon,
              color: widget.isActive ? Colors.red : Colors.black,
            ),
          ),
        ),
        SIZEHEIGHT10,
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: widget.isActive ? FontWeight.bold : FontWeight.w300,
              ),
        ),
      ],
    );
  }
}

class BlogCard extends StatefulWidget {
  final ApiBlogModel blog;
  const BlogCard({
    super.key,
    required this.blog,
  });

  @override
  State<BlogCard> createState() => _BlogCardState(blog);
}

class _BlogCardState extends State<BlogCard> {
  final ApiBlogModel blog;
  _BlogCardState(this.blog);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var difference = DateTime.now().difference(blog.publishedAt);
    var inDays = difference.inDays;
    var inHours = difference.inHours;
    var inMinutes = difference.inMinutes;
    var publishedTime = inMinutes < 60
        ? "$inMinutes min ago • Today"
        : inHours < 24
            ? "$inHours hours ago • Today"
            : "$inDays days ago • Older";
    return blog.title != "[Removed]"
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: size.width,
            child: Row(
              children: [
                Container(
                  width: 116,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(
                        blog.urlToImage ?? "https://c.biztoc.com/265/og.png",
                      ),
                      onError: (exception, stackTrace) {
                        const Text("Image Invalid");
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SIZEWIDTH20,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blog.title,
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.titleLarge!.copyWith(),
                      ),
                      SIZEHEIGHT10,
                      Row(
                        children: [
                          Text(
                            "${publishedTime.toString()} ",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
