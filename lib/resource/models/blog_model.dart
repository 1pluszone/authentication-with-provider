import 'package:intl/intl.dart';

class BlogModel {
  final String id;
  final String createdAt;
  final String title;
  final String imageUrl;

  BlogModel({this.id, this.createdAt, this.title, this.imageUrl});

  static final DateFormat formatter = DateFormat('MMMM dd, yyyy : hh mm ss');

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    String date = formatter.format(DateTime.parse(json['createdAt'] as String));
    return BlogModel(
      id: json['id'] as String,
      createdAt: date,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
