import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function onPressedCallBack;

  const LoginButton({Key key, this.onPressedCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressedCallBack,
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        width: 230,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Image.asset(
                'assets/images/google01.jpg',
                width: 70.0,
              ),
            ),
            Text(
              'Login with email',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
