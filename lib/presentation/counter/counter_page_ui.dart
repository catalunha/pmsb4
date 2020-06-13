import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/components/logout_button.dart';

class CounterPageUI extends StatelessWidget {
  final int counter;
  final Function increment;
  final int factorial;
  final String title;
  const CounterPageUI({
    Key key,
    this.counter,
    this.increment,
    this.factorial,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LogoutButton(),
            Text('Increment to: $counter'),
            Text('Factorial:$factorial'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          increment();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
