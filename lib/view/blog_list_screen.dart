import 'package:authentication_app_with_provider/provider/blogs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

class BlogListScreen extends StatefulWidget {
  @override
  _BlogListScreenState createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen>
    with AfterLayoutMixin<BlogListScreen> {
  BlogsProvider _blogsProvider;
  static const String eachBlogRoute = "eachBlogScreen";

  @override
  Widget build(BuildContext context) {
    _blogsProvider = Provider.of<BlogsProvider>(context);
    return Scaffold(body: blogPage(context));
  }

  Widget blogPage(BuildContext context) {
    switch (_blogsProvider.blogStatus) {
      case BlogStatus.networkError:
        return showErrorType(Text("Please check your internet connection"));
        break;
      case BlogStatus.error:
        return showErrorType(Text("An error occured!"));
        break;
      case BlogStatus.loaded:
        return showListView();
        break;
      default:
        return showErrorType(CircularProgressIndicator());
        break;
    }
  }

  Widget showListView() {
    return ListView.builder(
        itemCount: _blogsProvider.blogs.length,
        itemBuilder: (context, index) => Card(
              elevation: 5,
              child: ListTile(
                leading: CircleAvatar(
                    child: ClipOval(
                        child: Image.network(
                            _blogsProvider.blogs[index].imageUrl))),
                title: Text(_blogsProvider.blogs[index].title),
                subtitle: Text(_blogsProvider.blogs[index].createdAt),
                onTap: () => Navigator.of(context).pushNamed(eachBlogRoute,
                    arguments: _blogsProvider.blogs[index]),
              ),
            ));
  }

  Widget showErrorType(Widget child) {
    return Center(
      child: child,
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _blogsProvider.loadAllBlogs();
  }
}
