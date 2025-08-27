class Product {
  final String title;
  final double price;
  final String thumbnail;
  final String brand;
  final String description;

  Product({
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.brand,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] ?? '',
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      brand: json['brand'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
    );
  }
}
