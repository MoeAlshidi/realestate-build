import 'package:build/models/project_model.dart';

class UserModel {
  String? uId;
  String? fname;
  String? lname;
  String? email;
  String? role;
  String? profileImage;
  String? projectId;

  UserModel({
    this.uId,
    this.fname,
    this.lname,
    this.email,
    this.role,
    this.profileImage,
    this.projectId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      uId: json['uId'],
      fname: json['fname'],
      lname: json['lname'],
      role: json['role'],
      profileImage: json['imageProfile'],
      projectId: json['projectId'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'uId': uId,
      'email': email,
      'role': role,
      'imageProfile': profileImage,
      'projectId': projectId,
    };
  }
}
