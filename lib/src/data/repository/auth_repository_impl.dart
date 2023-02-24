import 'package:mallika/src/data/models/country_code_model.dart';
import 'package:mallika/src/data/network/api_service.dart';
import 'package:mallika/src/data/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl extends AuthRepository {
  final _apiService = ApiService();
  final _supabase = Supabase.instance.client;

  @override
  bool getIsLogin() {
    return false;
  }

  @override
  Future<List<CountryCodeModel>> getCountryCodes() async {
    List<CountryCodeModel> results = await _apiService.getCountryCodes();
    return results.toSet().toList();
  }

  @override
  Future<bool> signInWithOtp(String countryCode, String phoneNumber) async {
    try {
      String phoneNumberWithCountryCode =
          countryCode.replaceAll('+', '').replaceAll('-', '') + phoneNumber;
      await _supabase.auth.signInWithOtp(phone: phoneNumberWithCountryCode);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> verifyOtp(String code) async {
    try {
      AuthResponse response = await _supabase.auth.verifyOTP(
        token: code,
        type: OtpType.sms,
      );
      Session? session = response.session;
      User? user = session?.user;
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> signInWithGoogle() async {
    try {
      bool result = await _supabase.auth.signInWithOAuth(Provider.google);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
