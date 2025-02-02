import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/favorite_provider.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context, listen: false);

    // Load favorites when the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.loadFavorites();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushNamed(context, '/nav-bar');
          },
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          final favorites = provider.favorites;

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.grey.shade400,
                    size: MediaQuery.of(context).size.width * 0.2,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your favorites list is empty!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final product = favorites[index];
              return ListTile(
                title: Text(product.title),
                subtitle: Text("\$${product.price}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    provider.removeFavorite(product);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
