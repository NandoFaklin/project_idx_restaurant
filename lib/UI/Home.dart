import 'package:flutter/material.dart';
import 'package:myapp/UI/detail.dart';
import 'package:myapp/notifier/notifierRestaurant.dart';
import 'package:myapp/notifier/notifierTheme.dart'; // Pastikan mengimpor ThemeNotifier
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Restoran'),
        actions: [
          Row(
            children: [
              Icon(themeNotifier.themeMode == ThemeMode.light ? Icons.light_mode : Icons.dark_mode),
              Switch(
                value: themeNotifier.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                },
              ),
            ],
          ),
        ],
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
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                // Panggil searchRestaurants dari NotifierRestaurant
                Provider.of<NotifierRestaurant>(context, listen: false).searchRestaurants(value);
              },
            ),
          ),
          Expanded(
            child: Consumer<NotifierRestaurant>(
              builder: (context, notifier, _) {
                if (notifier.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (notifier.errorMessage.isNotEmpty) {
                  return Center(child: Text(notifier.errorMessage));
                } else if (notifier.restaurantData != null &&
                    notifier.restaurantData!.restaurants!.isNotEmpty) {
                  final filteredRestaurants = notifier.restaurantData!.restaurants!;

                  if (filteredRestaurants.isEmpty) {
                    return const Center(child: Text("Restoran tidak ditemukan."));
                  }

                  return ListView.builder(
                    itemCount: filteredRestaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = filteredRestaurants[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
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
                              const SizedBox(height: 5),
                              Text('Rating: ${restaurant.rating?.toString() ?? '-'}'),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetail(restaurantId: restaurant.id!,),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('Tidak ada data yang tersedia.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
