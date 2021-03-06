import 'package:authentication_app_with_provider/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider _provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: eachLoginWidget(_provider, context),
    );
  }

  Widget eachLoginWidget(UserProvider _provider, BuildContext context) {
    switch (_provider.status) {
      case LoggedInStatus.loggedOut:
        return SafeArea(child: loginWidget(context, _provider));
        break;
      case LoggedInStatus.loading:
        return Center(
          child: CircularProgressIndicator(),
        );
        break;
      default:
        return SizedBox();
        break;
    }
  }

  Widget loginWidget(BuildContext context, UserProvider _provider) {
    return Center(
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            Text("Login here"),
            emailField(),
            passwordField(),
            loginButton(context, _provider),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent, onPrimary: Colors.white),
              child: Text("Force login"),
              onPressed: () =>
                  Navigator.of(context).pushReplacementNamed("blogListScreen"),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
        controller: _emailController,
        decoration: InputDecoration(hintText: "put in your username here"),
        validator: (String value) {
          if (value.isEmpty) {
            return "Please put in your email";
          } else if (!value.contains("@")) {
            return "please put in a valid email";
          }
          return null;
        });
  }

  Widget passwordField() {
    return TextFormField(
        controller: _passwordController,
        obscureText: true,
        autocorrect: false,
        decoration: InputDecoration(
          hintText: "put in your password here",
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return "Please put in your password";
          } else if (value.length < 5) {
            return "password must be greater than 4";
          }
          return null;
        });
  }

  Widget loginButton(BuildContext context, UserProvider _provider) {
    return ElevatedButton(
      child: Text("Login"),
      onPressed: () => _provider.login(
          _emailController.text, _passwordController.text, context),
    );
  }
}
