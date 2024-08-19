import 'package:shopipi_mobile_v2/models/category.dart';

List<Category> buildCategoryTree(List<Category> categories, String? parentId) {
  final filteredCategories = categories
      .where((category) => parentId == null
          ? category.parentIds.isEmpty
          : category.parentIds.isNotEmpty &&
              category.parentIds.first == parentId)
      .toList();

  return filteredCategories.map((category) {
    final children = buildCategoryTree(categories, category.id);
    category.children = children;
    category.key = category.id; // Tùy chỉnh `key`
    category.label = category.name; // Tùy chỉnh `label`
    category.value =
        category.id; // Tùy chỉnh `value`, có thể tùy biến theo nhu cầu

    return category;
  }).toList();
}
