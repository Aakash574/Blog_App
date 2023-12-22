import 'package:blog_app/src/services/shared/user_shared_pref.dart';
import 'package:get/get.dart';
import 'package:blog_app/src/models/user_model.dart';

class UserController extends GetxController {
  late UserModel _user;
  final UserSharedPref _userSharedPref = UserSharedPref();

  UserModel get user => _user;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromPrefs();
  }

  Future<void> setUser(UserModel user) async {
    _user = user;
    await _userSharedPref.userPref(user);
    update();
  }

  Future<void> _loadUserFromPrefs() async {
    _user = await _userSharedPref.getUserPref();
    update();
  }

  Future<void> signOut() async {
    _user = UserModel.empty();
    await _userSharedPref.clearUserPrefs();
    
    update();
  }

  bool get isLoggedIn => _user.isEmpty;
}
