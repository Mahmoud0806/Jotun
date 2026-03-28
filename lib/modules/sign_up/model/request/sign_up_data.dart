  import 'dart:convert';

  class SignUpData {
    final String phoneNumber;
    final String fstName, lstName;
    final String passwordConfirmation;
    final String password;
    final int cityId;

    SignUpData(
        {required this.phoneNumber,
        required this.password,
        required this.lstName,
        required this.fstName,
        required this.cityId,
        required this.passwordConfirmation});

    Map<String, dynamic> toJson() => {
          "phone_number": phoneNumber,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "city_id": cityId,
          "fstName": fstName,
          "lstName": lstName,
        };

    String parse() {
      return jsonEncode(toJson());
    }
  }
