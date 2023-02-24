import 'package:mallika/src/data/models/country_code_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  bool getIsLogin();
  Future<List<CountryCodeModel>> getCountryCodes();
  Future<bool> signInWithOtp(String countryCode, String phoneNumber);
  Future<User?> verifyOtp(String code);
  Future<bool> signInWithGoogle();
}
