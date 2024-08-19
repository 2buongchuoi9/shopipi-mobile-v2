import 'package:shopipi_mobile_v2/models/category.dart';
import 'package:shopipi_mobile_v2/utils/index.dart';

import 'http.dart';

class CategoryApi {
  final Http _http;

  CategoryApi(this._http);

  Future<List<Category>> getCategories() async {
    try {
      final responseJson = await _http.get('/category');
      final data = responseJson['data'] as List<dynamic>;
      return data
          .map((item) => Category.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Lấy danh mục thất bại: $e');
      rethrow;
    }
  }

  Future<Category> getCategoryBySlug(String slug) async {
    final response = await _http.get('/category/$slug');
    final data = response['data'] as Map<String, dynamic>;
    return Category.fromJson(data);
  }

  Future<Category> addCategory(Category category) async {
    final response = await _http.post('/category', body: category.toJson());
    return Category.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<Category> updateCategory(String id, Category category) async {
    final response = await _http.post('/category/$id', body: category.toJson());
    return Category.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<void> deleteCategory(String slug) async {
    await _http.delete('/category/$slug');
  }
}

final categoryApi = CategoryApi(Http());
