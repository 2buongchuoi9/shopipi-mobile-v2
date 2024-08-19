import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopipi_mobile_v2/provider/categoryProvider.dart';
import 'package:shopipi_mobile_v2/screens/navbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lấy instance của CategoryProvider
    final categoryProvider = Provider.of<CategoryProvider>(context);

    // Tải danh mục khi widget được xây dựng
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (categoryProvider.categories.isEmpty) {
        categoryProvider.loadCategories();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.error != null) {
            return Center(child: Text('Có lỗi xảy ra: ${provider.error}'));
          } else if (provider.categories.isEmpty) {
            return Center(child: Text('Không có danh mục nào.'));
          } else {
            final categories = provider.categories;
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category.name),
                  subtitle: Text(category.slug),
                  leading: category.thumb.isNotEmpty
                      ? Image.network(
                          category.thumb,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : null,
                );
              },
            );
          }
        },
      ),
    );
  }
}
