import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentation/login/login_button.dart';
import 'package:pmsb4/presentation/login/login_form.dart';
import 'package:pmsb4/states/enums.dart';

class LoginPageDS extends StatelessWidget {
  final Function(String, String) loginEmailPassword;
  final Function loginGoogle;
  final AuthenticationStatus authenticationStatus;
  const LoginPageDS({
    Key key,
    this.loginEmailPassword,
    this.loginGoogle,
    this.authenticationStatus,
  }) : super(key: key);
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
            LoginForm(
              loginEmailPassword: loginEmailPassword,
              authenticationStatus: authenticationStatus,
            ),
            // LoginButton(
            //   loginGoogle: loginGoogle,
            // ),
          ],
        ),
      ),
    );
  }
}
