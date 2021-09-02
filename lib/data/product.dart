class Product {
  String? name;
  String? description;
  int? stock;
  double? price;

  Product({
    this.name,
    this.description,
    this.stock,
    this.price
  });

  Map<String, dynamic> toMap() => {
    "name": this.name,
    "description": this.description,
    "stock": this.stock,
    "price": this.price
  };

  Product.fromMap(Map<String, dynamic> map): this(
    name: '${map["name"]}',
    description: '${map["description"]}',
    stock: map["stock"],
    price: double.parse('${map["price"]}')
  );

  @override
  String toString() {
    return """Product {
      name: ${this.name},
      description: ${this.description},
      stock: ${this.stock},
      price: ${this.price}
    }""".trim();
  }
}