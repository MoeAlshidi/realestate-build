class ProjectModel {
  String? latitude;
  String? longitude;
  String? userID;
  String? username;
  String? projectId;
  double? progress;
  List<String>? projectImages;

  ProjectModel({
    this.progress,
    this.latitude,
    this.longitude,
    this.userID,
    this.username,
    this.projectId,
    this.projectImages,
  });
  ProjectModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    userID = json['userID'];
    progress = json['progress'];
    projectId = json['projectId'];
    projectImages = List.from(json['projectImages']);
  }
  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'userID': userID,
      'progress': progress,
      'username': username,
      'projectImages': projectImages,
      'projectId': projectId,
    };
  }
}
