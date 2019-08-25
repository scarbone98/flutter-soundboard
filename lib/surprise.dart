import 'package:flutter/material.dart';

class Surprise extends StatelessWidget {
  const Surprise({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        Positioned(
          child: FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(2))),
              child: Icon(
                Icons.arrow_left,
                color: Colors.white,
              ),
            ),
          ),
          top: 0,
          left: -10,
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/Christmas.png',
                fit: BoxFit.contain,
              )
            ],
          ),
        ),
      ]),
    );
  }
}
