import 'package:gerencia_de_estado/infra/services/auth_service._app.dart';
import 'package:gerencia_de_estado/src/controller.dart';
import 'package:get/get.dart';

class HomePageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    // Get.lazyPut<LoginController>(() => LoginController());
  }
}

class AuthDomainBinding {
  AuthService authApp;
  AuthDomainBinding() {
    authApp = AuthService();
  }
}
