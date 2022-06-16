import 'package:build/models/comment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedModel {
  String? name;
  String? id;
  String? feedId;
  String? feed;
  Timestamp? date;
  String? feedImages;
  String? profileImage;
  List<dynamic>? comments;

  FeedModel({
    this.id,
    this.feedId,
    this.name,
    this.date,
    this.feed,
    this.feedImages,
    this.profileImage,
    this.comments,
  });
  FeedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feedId = json['feedId'];
    name = json['name'];
    feed = json['feed'];
    date = json['date'];
    profileImage = json['profileImage'] ?? '';
    feedImages = json['feedImages'] ?? '';
    comments =
        List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x)));
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'feedId': feedId,
      'name': name,
      'feed': feed,
      'date': date,
      'feedImages': feedImages,
      'profileImage': profileImage,
      'comments': comments,
    };
  }
}
