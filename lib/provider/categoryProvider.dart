import 'package:flutter/material.dart';
import 'package:shopipi_mobile_v2/https/categoryApi.dart';
import 'package:shopipi_mobile_v2/models/category.dart';
import 'package:shopipi_mobile_v2/utils/index.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      var cate = await categoryApi.getCategories();
      _categories = buildCategoryTree(cate, null);
      _error = null;
    } catch (e) {
      _categories = [];
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
