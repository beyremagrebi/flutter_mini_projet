// home.dart


import 'package:authentication_firebase/pages/categorydetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'add.dart';

class Category {
  final String id;
  final String name;
  final String thumb;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.thumb,
    required this.description
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'].toString(),
      name: json['strCategory'],
      thumb: json['strCategoryThumb'],
      description: json['strCategoryDescription']
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          categories = jsonResponse
              .map((categoryJson) =>
                  Category.fromJson(categoryJson as Map<String, dynamic>))
              .toList();
        });
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error as needed
    }
  }
 Future<void> _deleteCategory(String categoryId) async {
    try {
      final response = await http.delete(
        Uri.parse('http://localhost:3000/categories/r'),
      );

      if (response.statusCode == 200) {
        // Category successfully deleted
        print('Category deleted successfully');
        fetchCategories(); // Refresh the category list after deleting a category
        Navigator.pop(context); // Navigate back to the previous screen (Home page)
      } else {
        throw Exception('Failed to delete category');
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
        title: Text("Categories"),
      ),
      body: categories.isNotEmpty
          ? ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return ListTile(
                  title: Text(category.name),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(category.thumb),
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryDetails(
                            id: category.id,
                            categoryName: category.name,
                            categoryImage: category.thumb,
                            categoryDescription: category.description,
                            onDelete: () {
                              // Pass the delete logic to the CategoryDetails page
                              _deleteCategory(category.id);
                              // Navigate back to the Home page after deletion
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                    child: Text('Details'),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCategoryForm()),
              );
            },
            tooltip: 'Add Category',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
