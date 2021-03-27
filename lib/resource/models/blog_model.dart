class BlogModel {
  final String id;
  final String createdAt;
  final String title;
  final String imageUrl;

  BlogModel({this.id, this.createdAt, this.title, this.imageUrl});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
