import 'package:accountant_app/constants.dart';
import 'package:accountant_app/models/user_model.dart';

class AuthService {
  Future<bool> signUp(String firstnameController, String lastnameController,
      String email, String password) async {
    final response = await client.auth.signUp(email: email, password: password);
    if (response.user != null) {
      await client.from('users').insert([
        {
          "id": response.user!.id,
          "first_name": firstnameController,
          "last_name": lastnameController,
          "email": email
        },
      ]).select();

      return true;
    } else {
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    var response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user != null && response.user!.id != "") {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signOut() async {
    await client.auth.signOut();
    return true;
  }

  Future<UserModel?> getCurrentUser(String userId) async {
    if (userId == "") {
      return null;
    }
    final responseData =
        await client.from('users').select("*").eq('id', userId);
    return UserModel.fromJson(responseData[0]);
  }
}
