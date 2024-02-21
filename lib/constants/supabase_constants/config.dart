import 'dart:convert';

import 'package:accountant_app/helpers/exceptions/exceptions_handler.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  SupabaseConfig._internal();
  static final SupabaseConfig _instance = SupabaseConfig._internal();

  late final Map<String, dynamic> _supabaseDataConfig;

  Map<String, dynamic> get supabaseDataConfig => _supabaseDataConfig;

  factory SupabaseConfig() => _instance;

  Session? get currentSession {
    Session? currentSession = client!.auth.currentSession;
    return currentSession;
  }

  String? get currentUserId {
    String? userId = client!.auth.currentSession?.user.id;
    return userId;
  }

  SupabaseClient? get client {
    SupabaseClient? client = Supabase.instance.client;
    return client;
  }

  Future<void> initSupabaseDataConfig() async {
    try {
      final String response =
          await rootBundle.loadString('assets/supabaseConfig.json');
      _supabaseDataConfig = await jsonDecode(response) as Map<String, dynamic>;
    } catch (error) {
      // SnackBarHelper.showErrorSnackBar(
      //     CustomExceptionHandler().handleException(error));
      throw Exception(CustomExceptionHandler().exceptionCatcher(error));
    }
  }
}
