import 'package:blog_app/src/services/firebase_login/firebase_login.dart';
import 'package:blog_app/src/utils/constants/size.dart';
import 'package:blog_app/src/utils/validation/validation.dart';
import 'package:blog_app/src/views/login_signup/signup_page.dart';
import 'package:blog_app/src/views/login_signup/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: PADDING24,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LottieBuilder.network(
                  "https://lottie.host/edff3d85-90ad-4ce5-ba10-c527d8d547ba/nTxVaNsxs7.json",
                ),
                Text(
                  "Login",
                  style: textTheme.headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SIZEHEIGHT20,
                LoginSignupWidget(
                  Validation.validateEmail,
                  false,
                  controller: _emailController,
                  hintText: 'Email',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: Size16,
                    ),
                    onPressed: () => _emailController.clear(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(FontAwesomeIcons.at),
                  formKey: _emailFormKey,
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
                      size: Size16,
                    ),
                    onPressed: () {
                      isVisible = !isVisible;
                      setState(() {});
                    },
                  ),
                  formKey: _passwordFormKey,
                ),
                SIZEHEIGHT20,
                GestureDetector(
                  onTap: () => loginData(),
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
                        "Login",
                        style: textTheme.titleMedium!
                            .copyWith(color: ConstColors.primaryColor),
                      ),
                    ),
                  ),
                ),
                SIZEHEIGHT10,
                Text("Or", style: textTheme.titleLarge),
                SIZEHEIGHT10,
                GestureDetector(
                  onTap: () => FirebaseLogin().signInWithGoogle(),
                  child: Container(
                    height: 64,
                    width: 230,
                    margin: MARIGN12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.black,
                          ),
                          Text(
                            "Sign Up with Google",
                            style: textTheme.titleMedium!
                                .copyWith(color: ConstColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SIZEHEIGHT20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "create an a Account?",
                      style:
                          textTheme.titleSmall!.copyWith(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () => Get.to(() => const SignupPage()),
                      child: Text(
                        "Sign Up",
                        style:
                            textTheme.titleMedium!.copyWith(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  loginData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      FirebaseLogin().login(_emailController.text, _passwordController.text);
      Fluttertoast.showToast(msg: "Login Successfully");
    } else {
      Fluttertoast.showToast(msg: "Invalid Credential");
    }
  }
}
