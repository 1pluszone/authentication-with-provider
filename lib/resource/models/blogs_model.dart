class BlogsModel {
  String id;
  String createdAt;
  String title;
  String imageUrl;

  BlogsModel({this.id, this.createdAt, this.title, this.imageUrl});

  BlogsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    title = json['title'];
    imageUrl = json['imageUrl'];
  }
}
