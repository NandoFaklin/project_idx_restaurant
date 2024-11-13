import 'package:flutter/material.dart';
import 'package:myapp/model/detailRestaurant.dart';
import 'package:myapp/model/restaurant.dart';
import 'package:myapp/repository/repositoryrestaurant.dart';

class NotifierRestaurant extends ChangeNotifier {
  // Menyimpan data restoran utama (list restoran)
  ModelRestaurant? _restaurantData;
  bool _isLoading = false;
  String _errorMessage = '';

  // Menyimpan data detail restoran
  ModelDetailRestaurant? _restaurantDetailData;

  ModelRestaurant? get restaurantData => _restaurantData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  ModelDetailRestaurant? get restaurantDetailData => _restaurantDetailData;

  // Getter untuk foods dan drinks (diambil dari _restaurantDetailData)
  List<Category> get foods => _restaurantDetailData?.restaurant?.menus?.foods ?? [];
  List<Category> get drinks => _restaurantDetailData?.restaurant?.menus?.drinks ?? [];

  // Fungsi untuk memuat data restoran
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

  // Fungsi untuk mencari restoran berdasarkan nama
  Future<void> searchRestaurants(String name) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final result = await RepoRestaurant.searchRestaurants(name);
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

  // Fungsi untuk mengambil detail restoran berdasarkan ID
  Future<void> fetchRestaurantDetail(String id) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final result = await RepoRestaurant.detailRestaurants(id);
      if (result.error == false) {
        _restaurantDetailData = result; // Menyimpan data detail restoran
      } else {
        _errorMessage = 'Gagal memuat detail restoran.';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
