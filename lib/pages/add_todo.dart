import 'package:flutter/material.dart';
import 'package:uas/model/category.dart';
import 'package:uas/model/todo.dart';
import 'package:uas/repository/repository.dart';
import 'package:intl/intl.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  String? _selectedCategory;
  List<Category>? _categoryList;

  @override
  void initState() {
    super.initState();
    _categoryList = []; // Initialize with empty list
    _loadCategories();
  }

  _loadCategories() async {
    Repository repo = Repository();
    List<dynamic> categories = await repo.readData('categories');
    setState(() {
      _categoryList =
          categories.map((c) => Category.mapToCategory(c) as Category).toList();
    });
  }

  // Method untuk dropdown onchange
  void _onCategoryChanged(String? value) {
    setState(() {
      _selectedCategory = value;
    });
  }

  _addTask() async {
    Todo newTask = Todo(
      title: _titleController.text,
      description: _descController.text,
      category: _selectedCategory ?? '',
      todoDate: _dateController.text,
      isFinished: 0,
    );

    Repository repo = Repository();
    var result = await repo.insertData('todos', Todo.todoToMap(newTask));

    if (result > 0) {
      Navigator.pop(context, newTask);
    } else {
      print("Data Tidak Dapat Dibuat. Hasil Value : " + result.toString());
    }
  }

  _selectedTodoDate(BuildContext context) async {
    DateTime dateTime = DateTime.now();
    var pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1999),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: "Tulis Judul",
              ),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: "Tulis Deskripsi",
              ),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: _onCategoryChanged,
              items: _categoryList!.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.name,
                  child: Text(category.name ?? ''),
                );
              }).toList(),
              decoration: const InputDecoration(
                labelText: 'Category',
                hintText: "Select Category",
              ),
            ),
            TextField(
              controller: _dateController,
              readOnly: true, // make it read-only
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: "Tulis Tanggal",
                prefixIcon: InkWell(
                  onTap: () {
                    _selectedTodoDate(context);
                  },
                  child: const Icon(Icons.calendar_today),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addTask,
                child: const Text("Add Task"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
