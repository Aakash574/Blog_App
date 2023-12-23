import 'package:blog_app/src/services/firebase_login/firebase_login.dart';
import 'package:blog_app/src/utils/validation/validation.dart';
import 'package:blog_app/src/views/login_signup/login_page.dart';
import 'package:blog_app/src/views/login_signup/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/size.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _phoneNoFormKey = GlobalKey<FormState>();
  final _passwordformKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 256,
                child: LottieBuilder.network(
                  "https://lottie.host/edff3d85-90ad-4ce5-ba10-c527d8d547ba/nTxVaNsxs7.json",
                  // fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                "Sign Up",
                style: textTheme.headlineLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SIZEHEIGHT20,
              LoginSignupWidget(
                (str) {
                  return null;
                },
                false,
                controller: _nameController,
                hintText: 'Name',
                suffixIcon: IconButton(
                  icon:
                      const Icon(Icons.close, color: Colors.grey, size: Size16),
                  onPressed: () => _nameController.clear(),
                ),
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(FontAwesomeIcons.textWidth),
                formKey: _nameFormKey,
              ),
              LoginSignupWidget(
                Validation.validateEmail,
                false,
                controller: _emailController,
                hintText: 'Email',
                suffixIcon: IconButton(
                  icon:
                      const Icon(Icons.close, color: Colors.grey, size: Size16),
                  onPressed: () => _emailController.clear(),
                ),
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(FontAwesomeIcons.at),
                formKey: _emailFormKey,
              ),
              LoginSignupWidget(
                Validation.validateMobile,
                false,
                controller: _phoneNoController,
                hintText: 'Phone No',
                suffixIcon: IconButton(
                  icon:
                      const Icon(Icons.close, color: Colors.grey, size: Size16),
                  onPressed: () => _phoneNoController.clear(),
                ),
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(FontAwesomeIcons.at),
                formKey: _phoneNoFormKey,
              ),
              LoginSignupWidget(
                Validation.validatePassword,
                isVisible,
                controller: _passwordController,
                prefixIcon: const Icon(FontAwesomeIcons.lock),
                hintText: 'Password',
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: FaIcon(
                      isVisible
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      color: Colors.grey,
                      size: Size16),
                  onPressed: () {
                    isVisible = !isVisible;
                    setState(() {});
                  },
                ),
                formKey: _passwordformKey,
              ),
              SIZEHEIGHT20,
              GestureDetector(
                onTap: _onSubmit,
                child: Container(
                  height: 64,
                  width: 230,
                  margin: MARIGN12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "Signup",
                      style: textTheme.titleMedium!
                          .copyWith(color: ConstColors.primaryColor),
                    ),
                  ),
                ),
              ),
              SIZEHEIGHT10,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account?",
                    style: textTheme.titleSmall!.copyWith(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () => Get.to(
                      () => const LoginPage(),
                    ),
                    child: Text(
                      "Login",
                      style:
                          textTheme.titleMedium!.copyWith(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onSubmit() {
    if (_emailFormKey.currentState!.validate()) {
      if (_phoneNoFormKey.currentState!.validate()) {
        if (_passwordformKey.currentState!.validate()) {
          FirebaseLogin().signUp(
            _nameController.text,
            _phoneNoController.text,
            _emailController.text,
            _passwordController.text,
          );
        }
      }
    } else {}
  }
}
