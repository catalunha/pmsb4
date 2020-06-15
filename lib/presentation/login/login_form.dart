import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentation/components/input_field.dart';
import 'package:pmsb4/states/enums.dart';

class LoginForm extends StatefulWidget {
  final Function(String, String) loginEmailPassword;
  final AuthenticationStatus authenticationStatus;
  LoginForm({
    Key key,
    this.loginEmailPassword,
    this.authenticationStatus,
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
  void validateInputs() {
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
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
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('Logar'),
              onTap: () {
                validateInputs();
              },
            ),
          ),
          widget.authenticationStatus == AuthenticationStatus.authenticating
              ? CircularProgressIndicator()
              // ? Text('authenticating.')
              : Container(),
              widget.authenticationStatus == AuthenticationStatus.unAuthenticated
              ? Text('Erro.')
              : Container(),
              widget.authenticationStatus == AuthenticationStatus.unInitialized
              ? Text('Bem vindo.')
              : Container(),
              widget.authenticationStatus == AuthenticationStatus.authenticated
              ? Text('Informe os dados')
              : Container(),
              Text(widget.authenticationStatus.toString()),
        ],
      ),
    );
  }
}
