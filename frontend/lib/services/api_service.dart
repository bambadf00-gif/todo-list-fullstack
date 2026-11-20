import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class ApiService {
  int? userId;
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

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Connexion réussie");
        userId = data["user_id"];
        return true;
      } else {
        debugPrint("Connexion échouée");
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createTask(
    int userId,
    String title,
    String description,
    bool status,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/users/$userId/tasks"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "description": description,
          "status": status,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Tâche créée avec succès");
      } else {
        debugPrint("Échec de création");
        debugPrint(response.body);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getTasks(int userid) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/users/$userid/tasks"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Erreur lors de la récupération des tâches");
      }
    } catch (e) {
      rethrow;
    }
  }


  Future<void> updateTask(
    int taskId,
    String title,
    String description,
    bool status,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/tasks/$taskId"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "description": description,
        "status": status,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      debugPrint("Tâche modifiée avec succès");
    } else {
      throw Exception("Erreur de modification : ${response.body}");
    }
  }

  Future<void> deleteTask(int taskId) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/tasks/$taskId"),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      debugPrint("Tâche supprimée avec succès");
    } else {
      throw Exception("Erreur de suppression : ${response.body}");
    }
  }

}
