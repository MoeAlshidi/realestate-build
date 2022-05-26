import 'package:build/models/user_model.dart';

class ProjectModel {
  String? id;
  String? latitude;
  String? longitude;
  String? userID;
  double? progress;

  ProjectModel({
    this.progress,
    this.id,
    this.latitude,
    this.longitude,
    this.userID,
  });
  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userID = json['userID'];
    progress = json['progress'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'userID': userID,
      'progress': progress,
    };
  }
}
