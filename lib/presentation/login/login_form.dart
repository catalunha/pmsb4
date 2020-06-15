import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentation/components/input_field.dart';
import 'package:pmsb4/states/enums.dart';

class LoginForm extends StatefulWidget {
  final Function(String) sendPasswordResetEmail;
  final Function(String, String) loginEmailPassword;
  final AuthenticationStatus authenticationStatus;
  LoginForm({
    Key key,
    this.loginEmailPassword,
    this.authenticationStatus,
    this.sendPasswordResetEmail,
  }) : super(key: key);
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final usernameController =
      TextEditingController(text: 'catalunha.mj@gmail.com');
  final passwordController = TextEditingController(text: 'pmsbto22@ta');
  void validateInputsLogin() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.loginEmailPassword(
        this.usernameController.text,
        this.passwordController.text,
      );
    } else {
      setState(() {});
    }
  }

  void validateInputsResetPassword() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.sendPasswordResetEmail(
        this.usernameController.text,
      );
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Informe os dados'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: <Widget>[
                InputField(
                    title: 'Nome de usuário', controller: usernameController),
                InputField(title: 'Senha:', controller: passwordController),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: ListTile(
              title: Center(child: Text('Logar')),
              onTap: () {
                validateInputsLogin();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: ListTile(
              title: Center(child: Text('Pedir Reset senha via email.')),
              onTap: () {
                validateInputsResetPassword();
              },
            ),
          ),
          widget.authenticationStatus == AuthenticationStatus.authenticating
              ? CircularProgressIndicator()
              : Container(),
          widget.authenticationStatus == AuthenticationStatus.unAuthenticated
              ? Text('Verifique Email e a Senha por favor.')
              : Container(),
          widget.authenticationStatus == AuthenticationStatus.unInitialized
              ? Text('Bem vindo.')
              : Container(),
          widget.authenticationStatus == AuthenticationStatus.authenticated
              ? Text('Acesso liberado.')
              : Container(),
          widget.authenticationStatus == AuthenticationStatus.sendPasswordReset
              ? Text('Veja seu email para nova senha.')
              : Container(),
          // Text(widget.authenticationStatus.toString()),
        ],
      ),
    );
  }
}
