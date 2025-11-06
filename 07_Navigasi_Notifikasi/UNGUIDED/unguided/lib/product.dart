class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final double rating;
  final int stock;
  final String category;
  final bool isNew;
  final bool isHot;
  final bool isOnSale;
  final double? originalPrice;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.stock,
    required this.category,
    this.isNew = false,
    this.isHot = false,
    this.isOnSale = false,
    this.originalPrice,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      stock: json['stock'],
      category: json['category'] ?? 'General',
      isNew: json['isNew'] ?? false,
      isHot: json['isHot'] ?? false,
      isOnSale: json['isOnSale'] ?? false,
      originalPrice: json['originalPrice']?.toDouble(),
    );
  }

  bool get isFavorite => false; // This will be managed by state management
}
