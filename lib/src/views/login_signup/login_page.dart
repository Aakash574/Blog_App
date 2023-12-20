import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../utils/constants/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                LottieBuilder.network(
                  "https://lottie.host/edff3d85-90ad-4ce5-ba10-c527d8d547ba/nTxVaNsxs7.json",
                ),
                Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black,
                          ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 18,
                          ),
                          onPressed: () => emailController.clear(),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        counterText: "",
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      validator: validateEmail,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isVisible,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black,
                          ),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: FaIcon(
                            isVisible
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.grey,
                            size: 18,
                          ),
                          onPressed: () {
                            isVisible = !isVisible;
                            setState(() {});
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        counterText: "",
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      validator: validatePassword,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    height: 64,
                    width: 230,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: ConstColors.primaryColor),
                      ),
                    ),
                  ),
                ),
                // const Spacer(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Or",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                GestureDetector(
                  child: Container(
                    height: 64,
                    width: 230,
                    margin: const EdgeInsets.all(12),
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
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: ConstColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  String? validatePassword(String? password) {
    List<String> symbols = ["@", "#", "\$", "!", "*", "&", "^"];
    var integers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

    bool symbolsTrue = symbols.any((element) => password!.contains(element));
    bool integersTrue =
        integers.any((element) => password!.contains(element.toString()));

    return password!.isNotEmpty
        ? password.length > 8 && symbolsTrue && integersTrue
            ? null
            : 'Invalid Password'
        : null;
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
}
