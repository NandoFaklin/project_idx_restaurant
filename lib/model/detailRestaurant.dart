class ModelDetailRestaurant {
  bool? error;
  String? message;
  Restaurant? restaurant;

  ModelDetailRestaurant({
    this.error,
    this.message,
    this.restaurant,
  });

  factory ModelDetailRestaurant.fromJson(Map<String, dynamic> json) {
    return ModelDetailRestaurant(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      restaurant: json['restaurant'] != null
          ? Restaurant.fromJson(json['restaurant'])
          : null,
    );
  }
}

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? city;
  String? address;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      pictureId: json['pictureId'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((category) => Category.fromJson(category))
          .toList(),
      menus: json['menus'] != null ? Menus.fromJson(json['menus']) : null,
      rating: (json['rating'] as num?)?.toDouble(),
      customerReviews: (json['customerReviews'] as List<dynamic>?)
          ?.map((review) => CustomerReview.fromJson(review))
          .toList(),
    );
  }
}

class Category {
  String? name;

  Category({this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String?,
    );
  }
}

class CustomerReview {
  String? name;
  String? review;
  String? date;

  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json['name'] as String?,
      review: json['review'] as String?,
      date: json['date'] as String?,
    );
  }
}

class Menus {
  List<Category>? foods;
  List<Category>? drinks;

  Menus({
    this.foods,
    this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List<dynamic>?)
          ?.map((food) => Category.fromJson(food))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>?)
          ?.map((drink) => Category.fromJson(drink))
          .toList(),
    );
  }
}
