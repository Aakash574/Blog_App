import 'package:flutter/material.dart';

import 'views/get_started/get_started.dart';

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: GetStarted(),
      ),
    );
  }
}
