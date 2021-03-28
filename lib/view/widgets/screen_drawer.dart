import 'package:authentication_app_with_provider/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(child: Text('Drawer Header')),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Consumer<UserProvider>(
            builder: (context, userPreference, child) => ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () => userPreference.logout(context),
            ),
          ),
        ],
      ),
    );
  }
}
