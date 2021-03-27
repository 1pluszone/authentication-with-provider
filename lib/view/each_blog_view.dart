import 'package:after_layout/after_layout.dart';
import 'package:authentication_app_with_provider/provider/blogs_provider.dart';
import 'package:authentication_app_with_provider/provider/each_blog_provider.dart';
import 'package:authentication_app_with_provider/resource/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EachBlog extends StatefulWidget {
  final String blogId;

  EachBlog({@required this.blogId});

  @override
  _EachBlogState createState() => _EachBlogState();
}

class _EachBlogState extends State<EachBlog> with AfterLayoutMixin<EachBlog> {
  EachBlogProvider _eachBlogProvider;
  @override
  Widget build(BuildContext context) {
    print(widget.blogId);
    return Scaffold(
      body: SafeArea(child: eachBlogView(context)),
    );
  }

  Widget eachBlogView(BuildContext context) {
    _eachBlogProvider = Provider.of<EachBlogProvider>(context);
    switch (_eachBlogProvider.blogStatus) {
      case BlogStatus.networkError:
        return showErrorType(Text("Please check your internet connection"));
        break;
      case BlogStatus.error:
        return showErrorType(Text("An error occured!"));
        break;
      case BlogStatus.loaded:
        return showBlogView(_eachBlogProvider.blog);
        break;
      default:
        return showErrorType(CircularProgressIndicator());
        break;
    }
  }

  Widget showBlogView(BlogModel blog) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          FadeInImage.assetNetwork(
              placeholder: "assets/loading.gif", image: blog.imageUrl),
          SizedBox(height: 20),
          Text(blog.title),
          Text(blog.createdAt),
        ],
      ),
    );
  }

  Widget showErrorType(Widget child) {
    return Center(
      child: child,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _eachBlogProvider.loadABlog(widget.blogId);
  }
}
