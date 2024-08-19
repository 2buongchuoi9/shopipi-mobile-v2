import 'package:flutter/material.dart';
import 'package:shopipi_mobile_v2/screens/navbar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
        toolbarHeight: 40,
      ),
      body: const Text('Category Screen'),
    );
  }
}
