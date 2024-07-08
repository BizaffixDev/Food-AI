import 'dart:convert';

SignupRequest signupRequestFromJson(String str) => SignupRequest.fromJson(json.decode(str));

String signupRequestToJson(SignupRequest data) => json.encode(data.toJson());

class SignupRequest {
  String fullname;
  String email;
  String password;
  String confirmPassword;
  String address;
  String phoneNumber;

  SignupRequest({
    required this.fullname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.address,
    required this.phoneNumber
  });

  factory SignupRequest.fromJson(Map<String, dynamic> json) => SignupRequest(
    fullname: json["fullname"],
    email: json["email"],
    password: json["password"],
    confirmPassword: json["confirmPassword"],
    address: json["address"],
    phoneNumber: json["phNum"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "email": email,
    "password": password,
    "confirmPassword": confirmPassword,
    "address": address,
    "phNum": phoneNumber,
  };
}
