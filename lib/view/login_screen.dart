import 'package:authentication_app_with_provider/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  UserProvider _provider;

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(child: loginWidget(context)),
    );
  }

  Widget loginWidget(BuildContext context) {
    return Center(
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: [
            emailField(),
            passwordField(),
            loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
        controller: _emailController,
        validator: (String value) {
          if (value.isEmpty) {
            return "Please put in your email";
          }
          return null;
        });
  }

  Widget passwordField() {
    return TextFormField(
        controller: _passwordController,
        validator: (String value) {
          if (value.isEmpty) {
            return "Please put in your password";
          }
          return null;
        });
  }

  Widget loginButton(BuildContext context) {
    return ElevatedButton(
      child: Text("Login"),
      onPressed: () => _provider.login(
          _emailController.text, _passwordController.text, context),
    );
  }
}
