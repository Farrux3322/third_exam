
class Product {
  String productId;
  int? count;
  String name;
  double price;
  String imageUrl;
  int? isLiked;
  int ?isCarted;

  Product({
    required this.productId,
    this.count,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isLiked,
    this.isCarted,
  });

  // Convert the Product object to a Map
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'count': count,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'isLiked': isLiked,
      'isCarted': isCarted,
    };
  }

  // Convert a Map object to a Product
  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'],
      count: map['count'],
      name: map['name'],
      price: map['price'],
      imageUrl: map['imageUrl'],
      isLiked: map['isLiked'],
      isCarted: map['isCarted'],
    );
  }
}
