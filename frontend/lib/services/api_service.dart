import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000";

  Future<void> createUser(String username, String mail, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": username,
          "mail": mail,
          "password": password,
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Inscription réussie");
      } else {
        debugPrint("Inscription échouée");
        debugPrint("Erreur : ${response.statusCode}");
        debugPrint("Détail : ${response.body}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login(String mail, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"mail": mail, "password": password}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Connexion réussie");
        return true;
      } else {
        debugPrint("Connexion échouée");
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
