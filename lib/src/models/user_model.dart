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
  final dynamic photoUrl;
  final String? providerId;
  final String? uid;

  UserModel({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.providerId,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        displayName: json["displayName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        photoUrl: json["photoURL"],
        providerId: json["providerId"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "phoneNumber": phoneNumber,
        "photoURL": photoUrl,
        "providerId": providerId,
        "uid": uid,
      };
}
