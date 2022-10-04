import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final productRepositoryProvider = Provider((ref) => ProductRepo());

class ProductRepo {
  Future<http.Response> getProduct() async {
    var url = Uri.https(
        '1hia8orbrk.execute-api.us-east-1.amazonaws.com', 'prod/products');
    try {
      var response = await http.get(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
