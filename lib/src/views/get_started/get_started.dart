import 'package:blog_app/src/controllers/blog_controller/api_blog_controller.dart';
import 'package:blog_app/src/controllers/login_controller.dart';
import 'package:blog_app/src/utils/constants/colors.dart';
import 'package:blog_app/src/views/dashboard/dashboard.dart';
import 'package:blog_app/src/views/login_signup/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  late AnimationController _lottieController;
  final UserController userController = Get.put(UserController());
  final ApiBlogController blogController = Get.put(ApiBlogController());

  @override
  void initState() {
    _lottieController = AnimationController(vsync: this);

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.to(
            () => userController.isLoggedIn
                ? const LoginPage()
                : const Dashboard(),
            duration: const Duration(milliseconds: 500),
            transition: Transition.fadeIn);
        _lottieController.reset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColors.primaryColor,
      body: SafeArea(
        child: Center(
          child: LottieBuilder.network(
              'https://lottie.host/edff3d85-90ad-4ce5-ba10-c527d8d547ba/nTxVaNsxs7.json',
              controller: _lottieController, onLoaded: (composition) {
            _lottieController.duration = composition.duration;
            _lottieController.forward();
          }),
        ),
      ),
    );
  }
}
