class ProductModelFields {
  static const String id = "_id";
  static const String productId = "productId";
  static const String count = "count";
  static const String name = "name";
  static const String price = "price";
  static const String imageUrl = "imageUrl";
  static const String isLike = "isLike";
  static const String productTable = "products";
}

class ProductModelSql {
  int? id;
  final int productId;
  final int count;
  final int isLike;
  final String name;
  final int price;
  final String imageUrl;

  ProductModelSql(
      {required this.productId,
      required this.count,
      required this.isLike,
      required this.name,
      required this.price,
      required this.imageUrl,
      this.id});

  ProductModelSql copyWith({
    int? productId,
    int? count,
    int? isLike,
    String? name,
    int? price,
    String? imageUrl,
    int? id,
  }) {
    return ProductModelSql(
      productId: productId ?? this.productId,
      count: count ?? this.count,
      isLike: isLike ?? this.isLike,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      id: id ?? this.id,
    );
  }

  factory ProductModelSql.fromJson(Map<String, dynamic> json) {
    return ProductModelSql(
        productId: json[ProductModelFields.productId],
        count: json[ProductModelFields.count],
        isLike: json[ProductModelFields.isLike],
        name: json[ProductModelFields.name],
        price: json[ProductModelFields.price],
        imageUrl: json[ProductModelFields.imageUrl]);
  }

  Map<String, dynamic> toJson() {
    return {
      ProductModelFields.name: name,
      ProductModelFields.price: price,
      ProductModelFields.isLike: isLike,
      ProductModelFields.count: count,
      ProductModelFields.productId: productId,
      ProductModelFields.imageUrl: imageUrl,
    };
  }
}
