import 'package:intl/intl.dart';

class BlogModel {
  final String id;
  final String createdAt;
  final String title;
  final String imageUrl;

  BlogModel({this.id, this.createdAt, this.title, this.imageUrl});

  static final DateFormat formatter = DateFormat('MMMM dd, yyyy : hh mm ss');

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;

    return data;
  }
}
