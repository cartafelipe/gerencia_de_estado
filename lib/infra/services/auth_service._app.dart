abstract class IAuthServiceApp {
  Future<bool> isAuthenticated();
}

class AuthService {
  Future<bool> isAuthenticated() async {
    try {
      //fazer chamada ao repositório local
      //encontrando usuário
      //validar token
      //token não válido return false
      //token válido return true
      //return false
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
