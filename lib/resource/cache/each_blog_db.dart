import 'dart:io';

import 'package:authentication_app_with_provider/resource/models/blog_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const String tableName = "blogTable";
const String columnId = "id";
const String createdAt = "createdAt";
const String title = "title";
const String imgUrl = "imageUrl";

class EachBlogDb {
  Database db;

  // EachBlogDb() {
  //   init();
  // }

  Future<void> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, "blog.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database eachBlogDb, int version) {
      eachBlogDb.execute("""
            CREATE TABLE $tableName
            (
              $columnId TEXT PRIMARY KEY,
              $createdAt TEXT,
              $title TEXT,
              $imgUrl TEXT
            )
          """);
    });
  }

  Future<BlogModel> fetchBlogFromDb(String id) async {
    await init();
    final List<Map> map = await db.query(tableName,
        limit: 1, columns: null, where: "$columnId = ?", whereArgs: [id]);

    if (map.length > 0) {
      return BlogModel.fromJson(map.first);
    }
    return null;
  }

  Future<int> addBlogToDb(BlogModel blog) async {
    await init();
    return await db.insert(
      tableName,
      blog.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

final eachblogDb = EachBlogDb();
