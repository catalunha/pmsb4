import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/states/types_states.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPageSizeMap {
  final double symmetricHorizontal;
  final double alturaTextField;
  final double larguraTextField;
  final double alturaBotao;
  final double larguraBotao;
  final double tamanhoMinCaixaLogin;

  LoginPageSizeMap({
    this.symmetricHorizontal,
    this.alturaTextField,
    this.larguraTextField,
    this.alturaBotao,
    this.larguraBotao,
    this.tamanhoMinCaixaLogin,
  });
}

class LoginPage2DS extends StatefulWidget {
  final Function(String) sendPasswordResetEmail;
  final Function(String, String) loginEmailPassword;
  final Function loginGoogle;
  final AuthenticationStatus authenticationStatus;
  const LoginPage2DS({
    Key key,
    this.loginEmailPassword,
    this.loginGoogle,
    this.authenticationStatus,
    this.sendPasswordResetEmail,
  }) : super(key: key);
  @override
  LoginPage2DSState createState() {
    return LoginPage2DSState();
  }
}

class LoginPage2DSState extends State<LoginPage2DS> {
  final _formKey = GlobalKey<FormState>();
  String _userName;
  String _password;
  LoginPageSizeMap loginPageSizeMap;

  void validateInputsLogin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.loginEmailPassword(
        _userName,
        _password,
      );
    } else {
      setState(() {});
    }
  }

  void validateInputsResetPassword() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      widget.sendPasswordResetEmail(_userName);
    } else {
      setState(() {});
    }
  }

  LoginPageSizeMap definirSizeMap(BuildContext context) {
    if (kIsWeb) {
      return MediaQuery.of(context).size.height > 600
          ? LoginPageSizeMap(
              symmetricHorizontal: MediaQuery.of(context).size.width * 0.30,
              tamanhoMinCaixaLogin: MediaQuery.of(context).size.width * 0.40,
              alturaTextField: MediaQuery.of(context).size.height * 0.06,
              larguraTextField: MediaQuery.of(context).size.width * 0.38,
              alturaBotao: MediaQuery.of(context).size.height * 0.06,
              larguraBotao: MediaQuery.of(context).size.width * 0.20,
            )
          : LoginPageSizeMap(
              symmetricHorizontal: MediaQuery.of(context).size.width * 0.20,
              tamanhoMinCaixaLogin: MediaQuery.of(context).size.width * 0.40,
              alturaTextField: MediaQuery.of(context).size.height * 0.10,
              larguraTextField: MediaQuery.of(context).size.width * 0.50,
              alturaBotao: MediaQuery.of(context).size.height * 0.10,
              larguraBotao: MediaQuery.of(context).size.width * 0.30,
            );
    } else {
      return LoginPageSizeMap(
        symmetricHorizontal: 20,
        tamanhoMinCaixaLogin: MediaQuery.of(context).size.width * 0.80,
        alturaTextField: MediaQuery.of(context).size.height * 0.08,
        larguraTextField: MediaQuery.of(context).size.width * 0.80,
        alturaBotao: MediaQuery.of(context).size.height * 0.08,
        larguraBotao: MediaQuery.of(context).size.width * 0.40,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    loginPageSizeMap = definirSizeMap(context);

    bool _validateEmail(String value) {
      bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);

      if (emailValid) {
        return true;
      } else {
        return false;
      }
    }

    bool _validatePassword(String value) {
      if (value.length < 6) {
        return false;
      }
      return true;
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: PmsbColors.fundo),
        padding: EdgeInsets.symmetric(
          horizontal: this.loginPageSizeMap.symmetricHorizontal,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height > 1000
                        ? MediaQuery.of(context).size.height * 0.10
                        : MediaQuery.of(context).size.height * 0.05,
                  ),
                ),

                // Imagem de cima
                Image.asset('assets/images/img_login_top.png'),

                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                ),

                Container(
                  constraints: BoxConstraints(
                      minWidth: this.loginPageSizeMap.tamanhoMinCaixaLogin),

                  //color: Colors.white,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: PmsbColors.texto_primario,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 5),
                    ],
                  ),

                  padding: EdgeInsets.only(top: 22),
                  child: Column(
                    children: <Widget>[
                      // Entrada de email
                      Container(
                        width: this.loginPageSizeMap.larguraTextField,
                        height: this.loginPageSizeMap.alturaTextField,
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 20,
                          right: 20,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5)
                          ],
                        ),
                        child: TextFormField(
                          // keyboardType: TextInputType.text,
                          onSaved: (value) => _userName = value,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Colors.black54,
                            ),
                            hintText: 'E-mail',
                          ),
                        ),
                      ),

                      // Entrada de senha
                      Container(
                        width: this.loginPageSizeMap.larguraTextField,
                        height: this.loginPageSizeMap.alturaTextField,
                        //distância de uma box para a outra
                        margin: EdgeInsets.only(top: 15),
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 20,
                          right: 20,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5)
                          ],
                        ),
                        child: TextFormField(
                          onSaved: (value) => _password = value,
                          obscureText: true,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.vpn_key,
                              color: Colors.black54,
                            ),
                            hintText: 'Senha',
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),

                      // Botao
                      GestureDetector(
                        onTap: () {
                          _formKey.currentState.save();
                          if (_validateEmail(this._userName) &&
                              _validatePassword(this._password)) {
                            _formKey.currentState.save();
                            widget.loginEmailPassword(
                              _userName,
                              _password,
                            );
                          } else {
                            _alerta(
                                "Verifique se o campo de e-mail e senha estão preenchidos corretamente.");
                          }
                        },
                        child: Container(
                          height: this.loginPageSizeMap.alturaBotao,
                          width: this.loginPageSizeMap.larguraBotao,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                PmsbColors.cor_destaque,
                                Colors.greenAccent
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'entrar'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.only(
                              top: 35,
                              right: 25,
                              bottom: 10,
                            ), // posições do texto esqueci minha senha
                            child: GestureDetector(
                              onTap: () {
                                _formKey.currentState.save();
                                if (_validateEmail(this._userName)) {
                                  widget.sendPasswordResetEmail(_userName);
                                  _alerta(
                                      "Um link para redefinição de senha foi enviado para o seu e-mail.");
                                } else {
                                  _alerta(
                                      "Para resetar sua senha preencha o campo de email.");
                                }
                              },
                              child: Text(
                                'Esqueci minha senha',
                                style: TextStyle(color: Colors.grey),
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03,
                  ),
                ),

                // Imagem inferior
                Image.asset('assets/images/img_login_bot.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _alerta(String msgAlerta) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: PmsbColors.card,
          title: Text(msgAlerta),
          actions: <Widget>[
            FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }
}
