import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterPageDS extends StatelessWidget {
  final int counter;
  final Function increment;
  final int factorial;
  final String title;
  const CounterPageDS({
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
