import 'package:blog_app/src/utils/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginSignupWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final IconButton suffixIcon;
  final IconData prefixIcon;
  final String hintText;
  final bool obscureText;
  final GlobalKey<FormState> formKey;

  const LoginSignupWidget(
    this.validator,
    this.obscureText, {
    super.key,
    required this.controller,
    required this.keyboardType,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.hintText,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PADDING12,
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.black,
              ),
          decoration: InputDecoration(
            prefixIcon: Container(
              padding: PADDING16,
              child: FaIcon(
                prefixIcon,
                size: Size16,
              ),
            ),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: Size16,
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
          validator: validator,
        ),
      ),
    );
  }
}
