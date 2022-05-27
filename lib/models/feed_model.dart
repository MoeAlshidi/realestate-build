class FeedModel {
  String? name;
  String? id;
  String? feed;
  DateTime? date;
  List<String>? feedImages;
  FeedModel({
    this.id,
    this.name,
    this.date,
    this.feed,
    this.feedImages,
  });
  FeedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    feed = json['feed'];
    date = DateTime.parse(json['date']);
    feedImages = json['feedImages'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'feed': feed,
      'date': date,
      'feedImages': feedImages,
    };
  }
}
