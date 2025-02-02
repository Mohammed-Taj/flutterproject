import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'product_model.dart'; // Import your Product model

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorites(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      image TEXT,
      review TEXT,
      seller TEXT,
      price REAL,
      colors TEXT,  -- Store colors as a JSON string
      category TEXT,
      rate REAL,
      quantity INTEGER
    )
  ''');
  }

  // Insert a favorite product
  Future<void> insertFavorite(Product product) async {
    final db = await database;
    try {
      await db.insert(
        'favorites',
        product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting favorite: $e'); // Debug print
      rethrow;
    }
  }

  // Get all favorite products
  Future<List<Product>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  // Delete a favorite product
  Future<void> deleteFavorite(String title) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'title = ?',
      whereArgs: [title],
    );
  }
}
