import 'dart:developer';
import 'dart:convert';

import 'package:blog_app/src/blog_app.dart';
import 'package:blog_app/src/models/user_model.dart';
import 'package:blog_app/src/views/dashboard/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/login_controller.dart';

class FirebaseLogin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final UserController userController = Get.find<UserController>();

  var googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    var user = await googleSignIn.signIn();

    final userModel = UserModel(
      displayName: user!.displayName,
      email: user.email,
      phoneNumber: "",
      photoURL: user.photoUrl,
      providerId: "",
      uid: user.id,
    );
    userController.setUser(userModel);
    Get.offAll(() => const BlogApp());
  }

  Future<void> storeInFirestore(UserModel userModel) async {
    try {
      final user = {
        "name": userModel.displayName,
        "email": userModel.email,
        "phoneNo": userModel.phoneNumber,
        "photoURL": userModel.photoURL,
        "uid": userModel.uid,
      };
      db.collection("users").add(user).then((DocumentReference doc) =>
          log('DocumentSnapshot added with ID: ${doc.id}'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> signUp(
    String name,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      userCredential.user!.updateDisplayName(name);

      final userModel = UserModel(
        displayName: name,
        email: userCredential.user!.email!,
        phoneNumber: phoneNumber,
        photoURL:
            'https://cdn.iconscout.com/icon/free/png-256/free-avatar-370-456322.png?f=webp',
        providerId: userCredential.user!.providerData.first.providerId,
        uid: userCredential.user!.uid,
      );

      storeInFirestore(userModel);
      userController.setUser(userModel);
      Get.offAll(() => const BlogApp());
    } catch (e) {
      print('Error during signup: $e');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log(userCredential.user.toString());

      final userModel = UserModel(
        displayName: userCredential.user!.displayName,
        email: userCredential.user!.email,
        phoneNumber: userCredential.user!.phoneNumber,
        photoURL: userCredential.user!.photoURL,
        providerId: userCredential.user!.providerData.first.providerId,
        uid: userCredential.user!.uid,
      );
      userController.setUser(userModel);
      Get.offAll(() => const Dashboard());
    } catch (e) {
      print('Error during login: $e');
    }
  }
}
