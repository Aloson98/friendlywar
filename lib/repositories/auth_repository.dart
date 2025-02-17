import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env["BASE_URL"] ?? ""));

  Future<Map<String, dynamic>> authenticateUser(
      String username, String password) async {
    try {
      final response = await _dio.post("friend/login/",
          data: {"username": username, "password": password});
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception("Failed to authenticate the user: ${e.toString()}");
    }
  }

  Future<List<dynamic>> loadMatches(String token) async {
    try {
      final response = await _dio.get("friend/matches/",
          options: Options(headers: {"Authorization": "Token $token"}));
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw Exception("Failed to load matches: ${e.toString()}");
    }
  }

  Future<Map<String, dynamic>> lostMatch(String token, String opponent) async {
    try {
      final response = await _dio.post("friend/matches/",
          data: {"team2": opponent},
          options: Options(headers: {"Authorization": "Token $token"}));
      return response.data;
    } on DioException catch (e) {
      throw Exception("Failed to load matches: ${e.toString()}");
    }
  }

  Future<List<dynamic>> listUsers(String token) async {
    try {
      final response = await _dio.get("friend/users/",
          options: Options(headers: {"Authorization": "Token $token"}));
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw Exception("Failed to get the list of users: ${e.toString()}");
    }
  }
}
