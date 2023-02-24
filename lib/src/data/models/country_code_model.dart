import 'package:equatable/equatable.dart';

class CountryCodeModel extends Equatable {
  final String phoneCode;
  final String countryName;

  const CountryCodeModel({
    required this.phoneCode,
    required this.countryName,
  });

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) {
    return CountryCodeModel(
      phoneCode: json['phone_code'],
      countryName: json['country_name'],
    );
  }

  @override
  List<Object?> get props => [phoneCode, countryName];
}
