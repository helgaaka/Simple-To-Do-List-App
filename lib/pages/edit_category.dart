import 'package:flutter/material.dart';
import 'package:uas/model/category.dart';
import 'package:uas/repository/repository.dart';

class EditCategoryPage extends StatefulWidget {
  final Category currentCategory;

  const EditCategoryPage({required this.currentCategory, super.key});

  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  final _nameController = TextEditingController();
  final Repository _repository = Repository();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentCategory.name!;
  }

  _editCategory() async {
    widget.currentCategory.name = _nameController.text;
    await _repository.updateCategory(Category.categoryToMap(widget.currentCategory));
    Navigator.pop(context, widget.currentCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Category"),
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
                onPressed: _editCategory,
                child: const Text('Edit Category'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
