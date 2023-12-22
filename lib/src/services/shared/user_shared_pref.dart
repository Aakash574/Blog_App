import 'package:blog_app/src/models/user_model.dart';
import 'package:blog_app/src/views/login_signup/login_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPref {
  static const String _userKey = 'user';

  Future<void> userPref(UserModel user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("user", user.toJsonString());
  }

  Future<UserModel> getUserPref() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final userString = sharedPreferences.getString('user');

    if (userString != null) {
      return UserModel.fromJsonString(userString);
    } else {
      return UserModel(
        displayName: '',
        email: '',
        phoneNumber: '',
        photoURL: '',
        providerId: '',
        uid: '',
      );
    }
  }

  Future<void> clearUserPrefs() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(_userKey);
    Get.offAll(() => const LoginPage());
  }
}
