import 'package:authentication_app_with_provider/view/blog_list_screen.dart';
import 'package:authentication_app_with_provider/view/each_blog_view.dart';
import 'package:authentication_app_with_provider/view/first_screen.dart';
import 'package:authentication_app_with_provider/view/login_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route routes(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/":
        {
          return MaterialPageRoute(builder: (context) => FirstScreen());
        }
        break;
      case "loginScreen":
        return MaterialPageRoute(builder: (context) => LoginScreen());
        break;
      case "blogListScreen":
        return MaterialPageRoute(builder: (context) => BlogListScreen());
        break;
      case "eachBlogScreen":
        return MaterialPageRoute(builder: (context) => EachBlog(blogId: args));
        break;
      default:
        return MaterialPageRoute(builder: (context) => NotFoundPage());
    }
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          "Sorry, we couldn't load your page for you... This shoudn't happen"),
    );
  }
}
