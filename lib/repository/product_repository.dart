import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_products/data/product.dart';

class ProductRepository {
  late final FirebaseFirestore _firestore;
  late final CollectionReference _products;

  ProductRepository({ FirebaseFirestore? firestore })
  : this._firestore = firestore ?? FirebaseFirestore.instance {
    this._products = _firestore.collection("products");
  }

  factory ProductRepository.create() {
    return ProductRepository();
  }

  Future<void> createProduct(Product product) async {
    return await _products
    .doc(product.name)
    .set(
      product.toMap()
    ).then((value) => print("Product ${product.name} added"))
    .catchError((error) => print("Failed to store ${product.name} product"));
  }

  Future<List<Product>> getProducts() async {
    final query = await _firestore.collection("products")
    .get()
    .then((snapshot) => snapshot.docs);

    return query.map((doc) => Product.fromMap(doc.data())).toList();
  }

  Future<void> deleteProduct(Product product) async {
    return await _products
    .doc(product.name)
    .delete();
  }

  Future<void> updateProduct(Product product) async {
    return _products
    .doc(product.name)
    .update(
      product.toMap()
    ).then((value) => print("Product ${product.name} updated"))
    .catchError((error) => print("Error when updating product ${product.name}"));
  }
}