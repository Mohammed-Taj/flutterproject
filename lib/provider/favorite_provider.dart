import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/database_helper.dart';
import 'package:shop/models/product_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Product> _favorites = [];
  List<Product> get favorites => _favorites;

  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Load favorites from the database
  Future<void> loadFavorites() async {
    _favorites.clear();
    _favorites.addAll(await _dbHelper.getFavorites());
    notifyListeners();
  }

  // Toggle a favorite product
  Future<void> toggleFavorite(Product product) async {
    if (_favorites.any((p) => p.title == product.title)) {
      await _dbHelper.deleteFavorite(product.title);
    } else {
      await _dbHelper.insertFavorite(product);
    }
    await loadFavorites(); // Refresh the list
  }

  // Remove a favorite product
  Future<void> removeFavorite(Product product) async {
    await _dbHelper.deleteFavorite(product.title);
    await loadFavorites(); // Refresh the list
  }

  // Check if a product is in favorites
  bool isExist(Product product) {
    return _favorites.any((p) => p.title == product.title);
  }

  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(
      context,
      listen: listen,
    );
  }
}
