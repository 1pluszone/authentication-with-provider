import 'package:authentication_app_with_provider/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_list_screen.dart';
import 'login_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstScreen(),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of(context);
    // final userProvider = context.read<UserProvider>();
    switch (userProvider.loggedInStatus) {
      case LoggedInStatus.loggedIn:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BlogListScreen()));
        break;
      case LoggedInStatus.loggedIn:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        break;
      case LoggedInStatus.unknown:
        return Scaffold(body: Container(color: Colors.redAccent));
    }
    return SizedBox();
  }
}
