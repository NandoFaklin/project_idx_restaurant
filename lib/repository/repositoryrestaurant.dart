import 'package:myapp/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepoRestaurant {
  static Future<ModelRestaurant> fetchRestaurants() async {
    try {
      final Uri uri = Uri.parse('https://restaurant-api.dicoding.dev/search?q=cafe');

      final response = await http.get(uri);
      print('Response from server: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        // Parse response JSON
        final responseData = jsonDecode(response.body);
        return ModelRestaurant.fromJson(responseData);
      } else {
        // Response failed
        print('Gagal memuat data restaurant: ${response.statusCode}');
        return ModelRestaurant(
          error: true,
          founded: 0,
          restaurants: [],
        );
      }
    } catch (e) {
      // Exception occurred during API call
      print('Error: $e');
      return ModelRestaurant(
        error: true,
        founded: 0,
        restaurants: [],
      );
    }
  }
}
