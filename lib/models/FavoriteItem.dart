class FavoriteItem {
  final int? id;
  final String title;
  final String category;
  final double price;
  final String image;

  FavoriteItem({
    this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
  });

  // Convert a FavoriteItem into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'price': price,
      'image': image,
    };
  }

  // Extract a FavoriteItem from a Map
  factory FavoriteItem.fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      price: map['price'],
      image: map['image'],
    );
  }
}
