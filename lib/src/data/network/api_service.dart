import 'package:dio/dio.dart';
import 'package:mallika/src/data/models/country_code_model.dart';

class ApiService {
  final _dio = Dio();

  Future<List<CountryCodeModel>> getCountryCodes() async {
    Response response = await _dio.get('https://countrycode.dev/api/calls');
    final results = response.data as List;
    List<CountryCodeModel> countryCodes = results
        .map((countryCode) => CountryCodeModel.fromJson(countryCode))
        .toList();
    return countryCodes;
  }
}
