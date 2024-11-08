import 'package:flutter/material.dart';
import 'package:myapp/model/restaurant.dart';
import 'package:myapp/repository/repositoryrestaurant.dart';

class NotifierRestaurant extends ChangeNotifier {
  ModelRestaurant? _restaurantData;
  bool _isLoading = false;
  String _errorMessage = '';

  ModelRestaurant? get restaurantData => _restaurantData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fungsi untuk memuat data dari API
  Future<void> fetchRestaurants() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final result = await RepoRestaurant.fetchRestaurants();
      if (result.error == false) {
        _restaurantData = result;
      } else {
        _errorMessage = 'Gagal memuat data restoran.';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
