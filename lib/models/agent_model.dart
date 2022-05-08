import 'package:build/models/project_model.dart';

class Agent {
  String? uId;
  String? fname;
  String? lname;
  String? email;

  Agent({
    this.uId,
    this.fname,
    this.lname,
    this.email,
  });

  Agent.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uId = json['uId'];
    fname = json['fname'];
    lname = json['lname'];
  }
  Map<String, dynamic> toMap() {
    return {
      'fname': fname,
      'lname': lname,
      'uId': uId,
      'email': email,
    };
  }
}
