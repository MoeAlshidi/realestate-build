import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String userId;
  String profileImage;
  String comment;
  Timestamp date;

  Comment({
    required this.id,
    required this.userId,
    required this.profileImage,
    required this.comment,
    required this.date,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        userId: json['userId'],
        profileImage: json['profileImage'],
        comment: json['comment'],
        date: json['date']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'profileImage': profileImage,
      'comment': comment,
      'date': date,
    };
  }
}
