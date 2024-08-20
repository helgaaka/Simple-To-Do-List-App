import 'package:flutter/material.dart';
import 'package:uas/model/category.dart';
import 'package:uas/repository/repository.dart';

class AddCategoryPage extends StatefulWidget {
  final Function(Category)? onCategoryAdded;

  const AddCategoryPage({super.key, this.onCategoryAdded});

  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final _nameController = TextEditingController();
  final Repository _repository = Repository();

  _addCategory() async {
    var category = Category(name: _nameController.text);
    await _repository.insertCategory(Category.categoryToMap(category));
    if (widget.onCategoryAdded != null) {
      widget.onCategoryAdded!(category);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                hintText: "Enter Category Name",
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addCategory,
                child: const Text('Add Category'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
