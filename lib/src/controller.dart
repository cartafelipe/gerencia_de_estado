import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:gerencia_de_estado/infra/navigation/navigation.dart';

import 'package:gerencia_de_estado/src/names_search.dart';
import 'package:get/get.dart';

class Controller extends GetController {
  static Controller get to => Get.find();
  int counter = 0;
  void increment() {
    counter++;
    update();
  }
}

class HomeController extends RxController {
  static HomeController get to => Get.find();
  final count = 0.obs;

  StreamController<List<String>> names =
      StreamController<List<String>>.broadcast();

  void fetchDataFromApi() async {
    Api api = Api();
    final response = await api.getNames();
    if (response == null)
      Get.snackbar('Erro', 'Não foi possível conectar ao servidos');
    else {
      names.add(response);
    }
  }

  @override
  void onClose() {
    names.close();
    super.onClose();
  }

  void increment() {
    count.value++;
  }
}

class RxLogin {
  final senha = ''.obs;
  final login = ''.obs;
  final auth = false.obs;
}

class LoginController extends RxController {
  static LoginController get to => Get.find();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  final loginx = RxLogin();

  void logOut() {
    //acessar API
    loginx.auth.value = false;
    loginx.login.value = '';
    loginx.senha.value = '';
    //persistir o estado do app localmente
  }

  void logIn() {
    if (loginController.text.isEmpty || senhaController.text.isEmpty) {
      Get.snackbar(
        'Atenção',
        'Login e senha são obrigatórios',
        icon: Icon(Icons.warning, color: Colors.white),
        shouldIconPulse: true,
        onTap: null,
        barBlur: 80,
        backgroundColor: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        colorText: Colors.white,
        snackStyle: SnackStyle.GROUNDED,
        duration: Duration(seconds: 3),
      );
    } else {
      loginx.login.value = loginController.text;
      loginx.senha.value = senhaController.text;

      loginx.auth.value = true;

      Get.offAndToNamed(Routes.HOME);
    }
  }

  @override
  void onInit() {
    // ever(loginx.auth, (auth) {
    //   if (!auth) {
    //     Get.off(LoginPage());
    //     // Get.toNamed('/');
    //   } else {
    //     Get.off(HomePage('Flutter Demo Home Page'),
    //         binding: HomePageBindings());
    //   }
    // });
  }
}

// class AppStore {
//   static void saveToPrefs(bool login) async {
//     final shared = await SharedPreferences.getInstance();
//     //  var string = json.encode(login);
//     shared.setBool('state', login);
//   }

//   static Future<bool> loadFromPrefs() async {
//     final shared = await SharedPreferences.getInstance();
//     var login = shared.getBool('state');
//     return login;
//   }
// }
