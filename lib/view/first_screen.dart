import 'package:authentication_app_with_provider/provider/blogs_provider.dart';
import 'package:authentication_app_with_provider/provider/each_blog_provider.dart';
import 'package:authentication_app_with_provider/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
        ChangeNotifierProvider<BlogsProvider>(create: (_) => BlogsProvider()),
        ChangeNotifierProvider<EachBlogProvider>(
            create: (_) => EachBlogProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        onGenerateRoute: Routes.routes,
        //home: FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    // final userProvider = context.read<UserProvider>();
    userProvider.checkLoginStatus(context);
    return Scaffold(body: Container(color: Colors.redAccent));
  }
}
