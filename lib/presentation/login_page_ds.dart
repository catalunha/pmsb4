import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentation/login_button.dart';

class LoginPageDS extends StatelessWidget {
  final Function login;

  const LoginPageDS({Key key, this.login}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LoginButton(
              onPressedCallBack: login,
            ),
          ],
        ),
      ),
    );
  }
}
