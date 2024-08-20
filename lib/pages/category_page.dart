import 'package:flutter/material.dart';
import 'package:uas/model/category.dart';
import 'package:uas/pages/add_category.dart';
import 'package:uas/pages/edit_category.dart';
import 'package:uas/repository/repository.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category>? _categoryList;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  late Repository repo;

  getCategories() async {
    _categoryList = [];
    repo = Repository();
    List<dynamic> resultCategories = await repo.readData('categories');
    for (var category in resultCategories) {
      _categoryList!.add(Category.mapToCategory(category));
    }
    setState(() {
      _categoryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCategoryPage(onCategoryAdded: (category) {
              setState(() {
                _categoryList!.add(category);
              });
            })),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: (_categoryList!.isEmpty)
          ? const Center(
              child: Text("No Categories"),
            )
          : ListView.builder(
              itemCount: _categoryList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(_categoryList![index].name ?? 'No Name'),
                      onTap: () async {
                        int temp = index;
                        var updateItem = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditCategoryPage(
                                currentCategory: _categoryList![index]),
                          ),
                        );
                        if (updateItem != null && updateItem is Category) {
                          setState(() {
                            _categoryList![temp] = updateItem;
                          });
                        }
                      },
                      onLongPress: () => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Are you sure to delete?"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No")),
                                ElevatedButton(
                                    onPressed: () {
                                      var result = repo.deleteData('categories',
                                          _categoryList![index].id);
                                      getCategories();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Yes"))
                              ],
                            );
                          }),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
