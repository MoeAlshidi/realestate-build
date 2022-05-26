import 'package:build/models/project_model.dart';

class UserModel {
  String? uId;
  String? fname;
  String? lname;
  String? email;
  String? role;
  String? profileImage;
  List<ProjectModel>? projectModel;

  UserModel({
    this.uId,
    this.fname,
    this.lname,
    this.email,
    this.role,
    this.profileImage,
    this.projectModel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<ProjectModel> projects = List<ProjectModel>.from(
        json["projects"]?.map((x) => ProjectModel.fromJson(x)) ?? []);
    return UserModel(
      email: json['email'],
      uId: json['uId'],
      fname: json['fname'],
      lname: json['lname'],
      role: json['role'],
      profileImage: json['imageProfile'],
      projectModel: projects,
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
      'projects': projectModel,
    };
  }
}
