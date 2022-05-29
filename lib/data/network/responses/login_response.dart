// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import '../../models/account_model.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.account,
  });

  int status;
  List<Account> account;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    account: List<Account>.from(json["account"].map((x) => Account.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "account": List<dynamic>.from(account.map((x) => x.toJson())),
  };
}

