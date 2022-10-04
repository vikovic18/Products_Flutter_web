import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:products_web/features/products/repository/product_repository.dart';
import 'package:products_web/models/products_model.dart';

final productControllerProvider = Provider((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return ProductController(productRepo: productRepository);
});

final allProductsProvider = FutureProvider((ref) {
  final productController = ref.watch(productControllerProvider);
  return productController.getProducts();
});

class ProductController {
  final ProductRepo productRepo;

  ProductController({required this.productRepo});

  List<ProductModel> _products = [];

  List<ProductModel> get allproducts => _products;

  Future<List<ProductModel>> getProducts() async {
    await productRepo.getProduct().then((response) {
      if (response.statusCode == 200) {
        final products = jsonDecode(response.body);

        List<ProductModel> loadedProducts = [];

        loadedProducts = products['Items']
            .map<ProductModel>((json) => ProductModel.fromJson(json))
            .toList();
        _products = loadedProducts;
      }
    }).catchError((error) {
      throw error;
    });
    return _products;
  }
}
