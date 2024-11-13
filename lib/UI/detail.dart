import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/notifier/notifierRestaurant.dart';


class RestaurantDetail extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetail({super.key, required this.restaurantId});

  @override
  _RestaurantDetailState createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Mengambil NotifierRestaurant dari Provider
    final notifier = Provider.of<NotifierRestaurant>(context, listen: false);
    
    // Memuat detail restoran hanya jika belum dimuat
    if (notifier.restaurantDetailData == null || notifier.restaurantDetailData?.restaurant?.id != widget.restaurantId) {
      notifier.fetchRestaurantDetail(widget.restaurantId);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil NotifierRestaurant dari Provider
    final notifier = Provider.of<NotifierRestaurant>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(notifier.restaurantDetailData?.restaurant?.name ?? 'Detail Restoran'),
      ),
      body: notifier.isLoading
          ? const Center(child: CircularProgressIndicator())  // Menampilkan loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar dengan animasi Hero
                    Hero(
                      tag: 'restaurant-image-${notifier.restaurantDetailData?.restaurant?.id}',
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/large/${notifier.restaurantDetailData?.restaurant?.pictureId}',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    // Nama restoran
                    Text(
                      notifier.restaurantDetailData?.restaurant?.name ?? 'Nama Tidak Diketahui',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    // Kota dan rating
                    Text(
                      'Kota: ${notifier.restaurantDetailData?.restaurant?.city ?? 'Kota Tidak Diketahui'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Rating: ${notifier.restaurantDetailData?.restaurant?.rating?.toString() ?? '-'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16.0),
                    // Deskripsi restoran
                    const Text(
                      'Deskripsi:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      notifier.restaurantDetailData?.restaurant?.description ?? 'Deskripsi tidak tersedia.',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16.0),
                    // Menu makanan
                    const Text(
                      'Menu Makanan:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,  // Agar list tidak mengganggu layout
                      physics: const NeverScrollableScrollPhysics(),  // Menghilangkan scroll independen
                      itemCount: notifier.foods.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(notifier.foods[index].name ?? 'Nama tidak tersedia'),
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // Menu minuman
                    const Text(
                      'Menu Minuman:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    // Menampilkan menu minuman
                    ListView.builder(
                      shrinkWrap: true,  // Agar list tidak mengganggu layout
                      physics: const NeverScrollableScrollPhysics(),  // Menghilangkan scroll independen
                      itemCount: notifier.drinks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(notifier.drinks[index].name ?? 'Nama tidak tersedia'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
