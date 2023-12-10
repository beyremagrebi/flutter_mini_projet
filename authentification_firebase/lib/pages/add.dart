// add.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({Key? key}) : super(key: key);

  @override
  _AddCategoryFormState createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController thumbController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> addCategory() async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/categories'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'strCategory': nameController.text,
          'strCategoryThumb': thumbController.text,
          'strCategoryDescription': descriptionController.text,
        }),
      );

      if (response.statusCode == 201) {
        // Category successfully created
        print('Category created successfully');
        Navigator.pop(context); // Close the add category form
      } else {
        print('Failed to create category. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('Failed to create category');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: thumbController,
              decoration: InputDecoration(labelText: 'Category Image URL'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Category Description'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: addCategory,
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
