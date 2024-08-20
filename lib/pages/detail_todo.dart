import 'package:flutter/material.dart';
import 'package:uas/model/category.dart';
import 'package:uas/model/todo.dart';
import 'package:uas/repository/repository.dart';
import 'package:intl/intl.dart';

class DetailEditTodo extends StatefulWidget {
  final Todo currentTodo;
  DetailEditTodo({super.key, required this.currentTodo});

  @override
  State<DetailEditTodo> createState() => _DetailEditTodoState();
}

class _DetailEditTodoState extends State<DetailEditTodo> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _dateController = TextEditingController();
  final _isFinishedController = TextEditingController();

  String? _selectedCategory;
  List<Category>? _categoryList = [];

  late Todo _currentItem;
  bool isDisabled = false;
  bool editButtonState = true;
  bool updateButtonState = false;

  List finishedOpt = ["Belum Selesai", "Selesai"];
  String finishedValue = "";

  @override
  void initState() {
    super.initState();
    _currentItem = widget.currentTodo;
    setData();
    _dataCategory();
  }

  void setData() {
    _titleController.text = _currentItem.title.toString();
    _descController.text = _currentItem.description.toString();

    _selectedCategory = _currentItem.category ?? '';

    _dateController.text = _currentItem.todoDate.toString();
    _isFinishedController.text = _currentItem.isFinished.toString();
    finishedValue = finishedOpt[int.parse(_isFinishedController.text)];
  }

  _dataCategory() async {
    Repository repo = Repository();
    List<dynamic> categories = await repo.readData('categories');
    setState(() {
      _categoryList =
          categories.map((c) => Category.mapToCategory(c) as Category).toList();
    });
  }

  _selectedTodoDate(BuildContext context) async {
    DateTime dateTime = DateTime.now();
    var pickedDate = await showDatePicker(
        context: context, firstDate: DateTime(1999), lastDate: DateTime(2030));

    if (pickedDate != null) {
      setState(() {
        dateTime = pickedDate;
        _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
      print((_dateController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail & Edit Data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                enabled: isDisabled,
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: "Tulis Judul",
                ),
              ),
              TextField(
                enabled: isDisabled,
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: "Tulis Deskripsi",
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                onChanged: isDisabled
                    ? (String? value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    : null,
                items: _categoryList!.map((Category category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: Text(category.name ?? ''),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Category',
                  hintText: "Pilih Kategori",
                ),
              ),
              TextField(
                enabled: isDisabled,
                controller: _dateController,
                decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: "Tulis Tanggal",
                    prefixIcon: InkWell(
                      onTap: () {
                        _selectedTodoDate(context);
                      },
                      child: const Icon(Icons.calendar_today),
                    )),
              ),
              ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        label: Text("Is Finished"),
                      ),
                      value: finishedValue,
                      items: finishedOpt
                          .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      hint: const Text("Category"),
                      onChanged: isDisabled
                          ? (value) {
                              setState(() {
                                finishedValue = value.toString();
                              });
                            }
                          : null)),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: editButtonState
                    ? () {
                        setState(() {
                          isDisabled = true;
                          editButtonState = false;
                          updateButtonState = true;
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text("Edit"),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: updateButtonState
                    ? () {
                        Todo updateTodo = Todo(
                          id: _currentItem.id,
                          title: _titleController.text,
                          description: _descController.text,
                          category: _selectedCategory,
                          todoDate: _dateController.text,
                          isFinished: finishedOpt.indexOf(finishedValue),
                        );
                        Repository repo = Repository();
                        repo.updateData('todos', Todo.todoToMap(updateTodo));
                        Navigator.pop(context, updateTodo);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                ),
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
