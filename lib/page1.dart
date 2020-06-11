import 'package:flutter/material.dart';
import 'package:gerencia_de_estado/src/controller.dart';
import 'package:get/get.dart';

class Page1 extends StatelessWidget {
  const Page1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.tbuild method, and use it to set our appbar title.
        title: Text('Item 1'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            GetX<HomeController>(
              builder: (s) => Text(s.count.string),
            ),
            GetX<LoginController>(
              builder: (c) => Text(c.loginx.login.string),
            ),
            GetX<LoginController>(
              builder: (c) => Text(c.loginx.auth.string),
            ),
          ],
        ),
      ),
    );
  }
}
