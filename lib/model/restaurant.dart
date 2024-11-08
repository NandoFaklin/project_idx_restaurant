class ModelRestaurant {
  bool? error;
  int? founded;
  List<Restaurant>? restaurants;

  ModelRestaurant({
    this.error,
    this.founded,
    this.restaurants,
  });

  // Fungsi untuk parsing dari JSON
  factory ModelRestaurant.fromJson(Map<String, dynamic> json) {
    return ModelRestaurant(
      error: json['error'],
      founded: json['founded'],
      restaurants: (json['restaurants'] as List)
          .map((restaurantJson) => Restaurant.fromJson(restaurantJson))
          .toList(),
    );
  }
}

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  // Fungsi untuk parsing dari JSON
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating']?.toDouble(),
    );
  }
}
