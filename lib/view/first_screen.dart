import 'package:authentication_app_with_provider/provider/user_provider.dart';
import 'package:authentication_app_with_provider/resource/cache/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blog_list_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserProvider>(create: (_) => UserProvider()),
      ],
      builder: (context, child) {
        final userProvider = context.watch<UserProvider>();
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FirstScreen(),
        );
      },
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of(context, listen: false);
    // final userProvider = context.read<UserProvider>();
    switch (userProvider.loggedInStatus) {
      case LoggedInStatus.loggedIn:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BlogListScreen()));
    }

    return Scaffold(body: Container(color: Colors.redAccent));
  }
}
