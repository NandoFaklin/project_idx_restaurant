import 'package:myapp/model/detailRestaurant.dart';
import 'package:myapp/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class RepoRestaurant {
   static final logger = Logger();
  static Future<ModelRestaurant> fetchRestaurants() async {
    try {
      final Uri uri = Uri.parse('https://restaurant-api.dicoding.dev/list');
      final response = await http.get(uri);
      logger.i('Response from server: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Parse response JSON
        final responseData = jsonDecode(response.body);
        return ModelRestaurant.fromJson(responseData);
      } else {
        // Response failed
        logger.i('Gagal memuat data restaurant: ${response.statusCode}');
        return ModelRestaurant(
          error: true,
          founded: 0,
          restaurants: [],
        );
      }
    } catch (e) {
      // Exception occurred during API call
      logger.i('Error: $e');
      return ModelRestaurant(
        error: true,
        founded: 0,
        restaurants: [],
      );
    }
  }

  static Future<ModelRestaurant> searchRestaurants(String name) async {
    try {
      final Uri uri = Uri.parse('https://restaurant-api.dicoding.dev//search?q=$name');
      final response = await http.get(uri);
      logger.i('Response from server: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Parse response JSON
        final responseData = jsonDecode(response.body);
        return ModelRestaurant.fromJson(responseData);
      } else {
        // Response failed
        logger.i('Gagal memuat data restaurant: ${response.statusCode}');
        return ModelRestaurant(
          error: true,
          founded: 0,
          restaurants: [],
        );
      }
    } catch (e) {
      // Exception occurred during API call
      logger.i('Error: $e');
      return ModelRestaurant(
        error: true,
        founded: 0,
        restaurants: [],
      );
    }
  }

  static Future<ModelDetailRestaurant> detailRestaurants(String id) async {
    try {
      final Uri uri = Uri.parse('https://restaurant-api.dicoding.dev/detail/$id');
      final response = await http.get(uri);
      logger.i('Response from server: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Parse response JSON
        final responseData = jsonDecode(response.body);
        return ModelDetailRestaurant.fromJson(responseData);
      } else {
        // Response failed
        logger.i('Gagal memuat data restaurant: ${response.statusCode}');
        return ModelDetailRestaurant(
          error: true,
        );
      }
    } catch (e) {
      // Exception occurred during API call
      logger.i('Error: $e');
      return ModelDetailRestaurant(
        error: true,
      );
    }
  }
}
