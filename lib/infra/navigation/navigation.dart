import 'package:gerencia_de_estado/infra/bindings/my_bindings.dart';
import 'package:gerencia_de_estado/main.dart';
import 'package:gerencia_de_estado/pages/login_page.dart';
import 'package:get/get.dart';

class Nav {
  static Map<String, GetRoute> routes = {
    Routes.LOGIN: GetRoute(
      page: LoginPage(),
      binding: LoginBindings(),
    ),
    Routes.HOME: GetRoute(
      page: HomePage(),
      binding: HomePageBindings(),
    ),
  };
}

class Routes {
  ///Check the authentication and define the initial route
  static Future<String> get initialRoute async {
    var authApp = AuthDomainBinding().authApp;
    if (await authApp.isAuthenticated()) {
      return HOME;
    }
    return LOGIN;
  }

  static const String LOGIN = '/login';
  static const String HOME = '/home';
}
