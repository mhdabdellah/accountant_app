import 'package:accountant_app/constants/supabase_constants/config.dart';
import 'package:accountant_app/models/user_model.dart';

class AuthService {
  Future<void> signUp(String firstnameController, String lastnameController,
      String email, String password) async {
    final response = await SupabaseConfig()
        .client
        .auth
        .signUp(email: email, password: password);
    if (response.user != null) {
      await SupabaseConfig().client.from('users').insert([
        {
          "id": response.user!.id,
          "first_name": firstnameController,
          "last_name": lastnameController,
        },
      ]).select();
    }
  }

  Future<void> signIn(String email, String password) async {
    await SupabaseConfig().client.auth.signInWithPassword(
          email: email,
          password: password,
        );
  }

  Future<void> signOut() async {
    await SupabaseConfig().client.auth.signOut();
  }

  Future<UserModel?> getCurrentUser(String userId) async {
    if (userId == "") {
      return null;
    }
    final responseData = await SupabaseConfig()
        .client
        .from('users')
        .select("*")
        .eq('id', userId);
    return UserModel.fromJson(responseData[0]);
  }
}
