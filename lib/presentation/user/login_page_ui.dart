import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentation/user/login_button_ui.dart';

class LoginPageUI extends StatelessWidget {
  final Function login;

  const LoginPageUI({Key key, this.login}) : super(key: key);
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
            LoginButtonUI(
              onPressedCallBack: login,
            ),
          ],
        ),
      ),
    );
  }
}
