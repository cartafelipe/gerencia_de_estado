import 'package:flutter/material.dart';
import 'package:gerencia_de_estado/components/components.dart';
import 'package:gerencia_de_estado/infra/navigation/navigation.dart';
import 'package:gerencia_de_estado/main.dart';
import 'package:gerencia_de_estado/src/controller.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginController loginx = Get.find();
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      decoration: lienarGradientBackgroud([
        Colors.green[900],
        Colors.green[400],
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
              controller: loginx.loginController,
              autofocus: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.perm_identity,
                  color: Colors.white,
                ),
              ),
              onChanged: (value) {
                LoginController.to.loginx.login.value = value;
              }),
          TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              obscureText: true,
              controller: loginx.senhaController,
              decoration: InputDecoration(
                labelText: 'Senha',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
              onChanged: (value) {
                LoginController.to.loginx.senha.value = value;
              }),
          GetX<LoginController>(
            init: LoginController(),
            builder: (_) => RaisedButton(
              child: Text('Entrar'),
              onPressed: () =>
                  Get.toNamed(Routes.HOME, arguments: 'Sou um argumento massa'),
            ),
          ),
        ],
      ),
    ));
  }
}
