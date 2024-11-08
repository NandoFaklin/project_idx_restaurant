import 'package:flutter/material.dart';
import 'package:myapp/UI/detail.dart';
import 'package:myapp/notifier/notifierRestaurant.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Memanggil data restoran saat halaman ini pertama kali dibuka
    Future.microtask(() {
      Provider.of<NotifierRestaurant>(context, listen: false).fetchRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Restoran'),
      ),
      body: Column(
        children: [
          // TextField dengan icon pencarian
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari nama restoran...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {}); // Memperbarui UI saat teks berubah
              },
            ),
          ),
          Expanded(
            child: Consumer<NotifierRestaurant>(
              builder: (context, notifier, _) {
                if (notifier.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (notifier.errorMessage.isNotEmpty) {
                  return Center(child: Text(notifier.errorMessage));
                } else if (notifier.restaurantData != null &&
                    notifier.restaurantData!.restaurants!.isNotEmpty) {
                  // Filter data sesuai input pencarian
                  final query = _searchController.text.toLowerCase();
                  final filteredRestaurants = notifier.restaurantData!.restaurants!
                      .where((restaurant) =>
                          restaurant.name!.toLowerCase().contains(query))
                      .toList();

                  if (filteredRestaurants.isEmpty) {
                    return Center(child: Text("Restoran tidak ditemukan."));
                  }

                  return ListView.builder(
                    itemCount: filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = filteredRestaurants[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Hero(
                            tag: 'restaurant-image-${restaurant.id}',
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(restaurant.name ?? 'Nama Tidak Diketahui'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(restaurant.city ?? 'Kota Tidak Diketahui'),
                              SizedBox(height: 5),
                              Text('Rating: ${restaurant.rating?.toString() ?? '-'}'),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetail(restaurant: restaurant),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('Tidak ada data yang tersedia.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
