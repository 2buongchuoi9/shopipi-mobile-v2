// import 'package:shopipi_mobile_v2/https/http.dart';
// import 'package:shopipi_mobile_v2/models/page.dart';
// import 'package:shopipi_mobile_v2/models/product.dart';
// import 'dart:convert';

// class ProductApi {
//   final Http _http;

//   ProductApi(this._http);

//   Future<Page<Product>> getAllProducts({Map<String, dynamic>? params}) async {
//     final response = await _http.get('/product', params: params);

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);

//       final content = (data['content'] as List)
//           .map((json) => Product.fromJson(json))
//           .toList();

//       final page = Page<Product>(
//         content: content,
//         totalPage: data['totalPage'],
//         currentPage: data['currentPage'],
//         pageSize: data['pageSize'],
//         totalElement: data['totalElement'],
//         last: data['last'],
//       );

//       return page;
//     } else {
//       throw Exception('Failed to load products');
//     }
//   }

//   Future<Product> addProduct(Product product) async {
//     final response = await _http.post('/product', product.toJson());
//     if (response.statusCode == 200) {
//       return Product.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to add product');
//     }
//   }

//   Future<Product> updateProduct(String id, Product product) async {
//     final response = await _http.put('/product/$id', product.toJson());
//     if (response.statusCode == 200) {
//       return Product.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to update product');
//     }
//   }

//   Future<Product> findProductBySlug(String slug) async {
//     final response = await _http.get('/product/slug/$slug');
//     if (response.statusCode == 200) {
//       return Product.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to find product');
//     }
//   }

//   Future<Product> findProductById(String id) async {
//     final response = await _http.get('/product/id/$id');
//     if (response.statusCode == 200) {
//       return Product.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to find product');
//     }
//   }

//   Future<bool> updateManyState(List<String> ids, String state) async {
//     final response = await _http
//         .post('/product/update-many-state', {'ids': ids, 'value': state});
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to update product state');
//     }
//   }

//   Future<bool> deleteProduct(String id) async {
//     final response = await _http.delete('/product/$id');
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to delete product');
//     }
//   }

//   Future<Map<String, int>> countProduct(String shopId) async {
//     final response = await _http.get('/product/count/$shopId');
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body) as List;
//       return {
//         'countProduct': data[0],
//         'countVariant': data[1],
//         'countSold': data[2],
//       };
//     } else {
//       throw Exception('Failed to count products');
//     }
//   }
// }

// final productApi = ProductApi(Http());
