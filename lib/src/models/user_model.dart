// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? displayName;
  final String? email;
  final dynamic phoneNumber;
  final dynamic photoURL;
  final String? providerId;
  final String? uid;

  UserModel({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.providerId,
    this.uid,
  });

  factory UserModel.empty() {
    return UserModel(
      displayName: '',
      email: '',
      phoneNumber: '',
      photoURL: '',
      providerId: '',
      uid: '',
    );
  }

  factory UserModel.fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return UserModel.fromJson(json);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        displayName: json['displayName'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        photoURL: json['photoURL'] ?? '',
        providerId: json['providerId'] ?? '',
        uid: json['uid'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "phoneNumber": phoneNumber,
        "photoURL": photoURL,
        "providerId": providerId,
        "uid": uid,
      };

  String toJsonString() {
    return jsonEncode(toJson());
  }

  bool get isEmpty {
    return displayName!.isEmpty &&
        email!.isEmpty &&
        phoneNumber.isEmpty &&
        photoURL.isEmpty &&
        providerId!.isEmpty &&
        uid!.isEmpty;
  }

  // Check if the user is logged in
  bool get isLoggedIn => !isEmpty;
}
