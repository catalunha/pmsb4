import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentation/login/login_button.dart';
import 'package:pmsb4/presentation/login/login_form.dart';

class LoginPageDS extends StatelessWidget {
  final Function(String,String) loginEmailPassword;
final Function loginGoogle;
  const LoginPageDS({Key key, this.loginEmailPassword, this.loginGoogle}) : super(key: key);
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
            LoginForm(loginEmailPassword: loginEmailPassword,),
            // LoginButton(
            //   loginGoogle: loginGoogle,
            // ),
          ],
        ),
      ),
    );
  }
}
