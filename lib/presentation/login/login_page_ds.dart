import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/states/enums.dart';

class LoginPageDS extends StatefulWidget {
  final Function(String) sendPasswordResetEmail;
  final Function(String, String) loginEmailPassword;
  final Function loginGoogle;
  final AuthenticationStatus authenticationStatus;
  const LoginPageDS({
    Key key,
    this.loginEmailPassword,
    this.loginGoogle,
    this.authenticationStatus,
    this.sendPasswordResetEmail,
  }) : super(key: key);
  @override
  LoginPageDSState createState() {
    return LoginPageDSState();
  }
}

class LoginPageDSState extends State<LoginPageDS> {
  static final formKey = GlobalKey<FormState>();
  String _userName;
  String _password;
  void validateInputsLogin() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.loginEmailPassword(
        _userName,
        _password,
      );
    } else {
      setState(() {});
    }
  }

  void validateInputsResetPassword() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.sendPasswordResetEmail(_userName);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Page'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
                Text('Informe os dados'),
                TextFormField(
                  initialValue: 'catalunha.mj@gmail.com',
                  decoration: InputDecoration(
                    labelText: 'Email:',
                  ),
                  onSaved: (value) => _userName = value,
                ),
                TextFormField(
                  initialValue: 'pmsbto22@ta',
                  decoration: InputDecoration(
                    labelText: 'Password:',
                  ),
                  onSaved: (value) => _password = value,
                ),
                ListTile(
                  title: Center(child: Text('Logar')),
                  onTap: () {
                    validateInputsLogin();
                  },
                ),
                ListTile(
                  title: Center(child: Text('Pedir Reset senha via email.')),
                  onTap: () {
                    validateInputsResetPassword();
                  },
                ),
                ListTile(
                  enabled: false,
                  title: Center(child: Text('Login com conta google.')),
                  onTap: () {
                    widget.loginGoogle();
                  },
                ),
                ListTile(
                  enabled: false,
                  title: Center(child: Text('Login com numero de telefone.')),
                  onTap: () {},
                ),
                widget.authenticationStatus ==
                        AuthenticationStatus.authenticating
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatus.unAuthenticated
                    ? Text('Verifique Email e a Senha por favor.')
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatus.unInitialized
                    ? Text('Bem vindo.')
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatus.authenticated
                    ? Text('Acesso liberado.')
                    : Container(),
                widget.authenticationStatus ==
                        AuthenticationStatus.sendPasswordReset
                    ? Text('Veja seu email para nova senha.')
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
