import 'package:blog_app/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../login_signup/login_page.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  late AnimationController _lottieController;
  @override
  void initState() {
    _lottieController = AnimationController(vsync: this);

    _lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.to(() => const LoginPage(),
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
