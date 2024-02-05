import 'package:accountant_app/constants.dart';
import 'package:accountant_app/models/user_model.dart';

class AuthService {
  // s'inscrire
  Future<UserModel?> signUp(String name, String email, String password) async {
    // Name,Email and password sign up
    final response = await client.auth
        .signUp(email: email, password: password, data: {"name": name});
    // UserModel? user = UserModel.fromMap(response.user);

    final response2;
    if (response.user != null) {
      response2 = await client.from('users').insert([
        {"id": response.user!.id, "first_name": name, "last_name": name},
      ]).select();

      print("response2 : $response2");
    } else {
      print("error in signUp");
    }

    print("register result response.user : ${response.user}");
    return null;
  }

  // se connecter
  Future<UserModel?> signIn(String email, String password) async {
    // Email and password login
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final response2 =
        await client.from('users').select("*").eq('id', response.user!.id);

    print("response2 : $response2");
    // response.user;
    print("login result response.user : ${response.user!.id}");
    return null;
  }

  // se déconnecter
  Future<bool> signOut() async {
    await client.auth.signOut();
    return true;
  }
}
