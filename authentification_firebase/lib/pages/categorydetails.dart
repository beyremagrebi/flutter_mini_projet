// category_details.dart

import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  final String id;
  final String categoryName;
  final String categoryImage;
  final String categoryDescription;
  final VoidCallback onDelete;

  CategoryDetails({
    required this.id,
    required this.categoryName,
    required this.categoryImage,
    required this.categoryDescription,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              categoryImage,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 16),
            Text(
              'Category Name: $categoryName',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Category ID: $id',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Description: $categoryDescription',
              style: TextStyle(fontSize: 16),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
