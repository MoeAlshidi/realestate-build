import 'package:cloud_firestore/cloud_firestore.dart';

class FeedModel {
  String? name;
  String? id;
  String? feed;
  Timestamp? date;
  String? feedImages;
  String? profileImage;
  FeedModel({
    this.id,
    this.name,
    this.date,
    this.feed,
    this.feedImages,
    this.profileImage,
  });
  FeedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feed = json['feed'];
    date = json['date'];
    profileImage = json['profileImage'] ?? '';
    feedImages = json['feedImages'] ?? '';
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'feed': feed,
      'date': date,
      'feedImages': feedImages,
      'profileImage': profileImage,
    };
  }
}
