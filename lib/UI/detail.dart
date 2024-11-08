import 'package:flutter/material.dart';
import 'package:myapp/model/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetail({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name ?? 'Detail Restoran'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar dengan animasi Hero
              Hero(
                tag: 'restaurant-image-${restaurant.id}',
                child: Image.network(
                  'https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.0),
              // Nama restoran
              Text(
                restaurant.name ?? 'Nama Tidak Diketahui',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              // Kota dan rating
              Text(
                'Kota: ${restaurant.city ?? 'Kota Tidak Diketahui'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8.0),
              Text(
                'Rating: ${restaurant.rating?.toString() ?? '-'}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16.0),
              // Deskripsi restoran
              Text(
                'Deskripsi:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                restaurant.description ?? 'Deskripsi tidak tersedia.',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
