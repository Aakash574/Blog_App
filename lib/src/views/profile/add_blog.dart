import 'package:blog_app/src/controllers/login_controller.dart';
import 'package:blog_app/src/services/blogs/blog_database.dart';
import 'package:blog_app/src/utils/constants/colors.dart';
import 'package:blog_app/src/utils/constants/size.dart';
import 'package:blog_app/src/utils/validation/validation.dart';
import 'package:blog_app/src/views/login_signup/widgets/widgets.dart';
import 'package:blog_app/src/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AddBlogs extends StatefulWidget {
  const AddBlogs({super.key});

  @override
  State<AddBlogs> createState() => _AddBlogsState();
}

class _AddBlogsState extends State<AddBlogs>
    with SingleTickerProviderStateMixin {
  final _titleFormKey = GlobalKey<FormState>();
  final _descriptionFormKey = GlobalKey<FormState>();
  final _contentFormKey = GlobalKey<FormState>();
  final _imageUrlFormKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();

  late AnimationController lottieController;
  final UserController userController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    lottieController = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: PADDING12,
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
              Text(
                "New Blog",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SIZEHEIGHT16,
              LoginSignupWidget(
                (p0) => null,
                false,
                controller: _titleController,
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () => _titleController.clear(),
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
                prefixIcon: const Icon(
                  FontAwesomeIcons.italic,
                  // size: Size20,
                ),
                hintText: "title",
                formKey: _titleFormKey,
              ),
              LoginSignupWidget(
                (p0) => null,
                false,
                controller: _descriptionController,
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () => _descriptionController.clear(),
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
                prefixIcon: const Icon(
                  FontAwesomeIcons.italic,
                  // size: Size20,
                ),
                hintText: "Description",
                formKey: _descriptionFormKey,
              ),
              LoginSignupWidget(
                (p0) => null,
                false,
                controller: _contentController,
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () => _contentController.clear(),
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
                prefixIcon: const Icon(
                  FontAwesomeIcons.italic,
                  // size: Size20,
                ),
                hintText: "Content",
                formKey: _contentFormKey,
              ),
              LoginSignupWidget(
                Validation.validateUrl,
                false,
                controller: _imageUrlController,
                keyboardType: TextInputType.text,
                suffixIcon: IconButton(
                  onPressed: () => _imageUrlController.clear(),
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                ),
                prefixIcon: const Icon(
                  FontAwesomeIcons.italic,
                  // size: Size20,
                ),
                hintText: "Image Url",
                formKey: _imageUrlFormKey,
              ),
              SIZEHEIGHT16,
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: addBlog,
                  child: Container(
                    height: 64,
                    width: 164,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Add Blog",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: ConstColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addBlog() async {
    lottieController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.offAll(() => const ProfilePage(),
            duration: const Duration(milliseconds: 500),
            transition: Transition.fadeIn);
        lottieController.reset();
      }
    });
    if (_imageUrlFormKey.currentState!.validate() &&
        _titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      final isPosted = await BlogDatabase().storeBlogs(
          _titleController.text,
          _descriptionController.text,
          _contentController.text,
          _imageUrlController.text);
      if (isPosted) {
        Get.dialog(
          LottieBuilder.network(
              "https://lottie.host/f291b04a-f2ec-40d4-9914-3e5a643c1882/ixjSm0jOiB.json",
              controller: lottieController, onLoaded: (composition) {
            lottieController.duration = composition.duration;
            lottieController.forward();
          }),
        );
      }
    } else {
      Fluttertoast.showToast(msg: "All field Required");
    }
  }
}
