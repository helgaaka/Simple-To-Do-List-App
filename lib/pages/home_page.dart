import 'package:flutter/material.dart';
import 'package:uas/model/todo.dart';
import 'package:uas/pages/add_todo.dart';
import 'package:uas/pages/detail_todo.dart';
import 'package:uas/pages/drawer_page.dart';
import 'package:uas/repository/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo>? _todoList;
  @override
  void initState() {
    super.initState();
    getTodo();
  }

  late Repository repo;
  getTodo() async {
    _todoList = [];
    repo = Repository();
    List<dynamic> resultTodo = await repo.readData('todos');
    for (var todo in resultTodo) {
      _todoList!.add(Todo.mapToTodo(todo));
    }
    setState(() {
      _todoList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List App"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DrawerNavigationPage()));
            },
            icon: Icon(Icons.menu)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Todo? newTask = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTodoPage()));
          if (newTask != null) {
            getTodo(); 
          }
        },
        child: const Icon(Icons.add),
      ),
      body: (_todoList!.isEmpty)
          ? const Center(
              child: Text("No Activity"),
            )
          : ListView.builder(
              itemCount: _todoList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      title: Text(_todoList![index].title ?? 'No Title'),
                      subtitle:
                          Text(_todoList![index].category ?? 'No Category'),
                      trailing: Text(_todoList![index].todoDate ?? 'No Date'),
                      onTap: () async {
                        int temp = index;
                        var updateItem = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailEditTodo(currentTodo: _todoList![index]),
                          ),
                        );
                        if (updateItem != null) {
                          getTodo();
                        }
                      },
                      onLongPress: () => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Yakin Menghapus? "),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No")),
                                ElevatedButton(
                                    onPressed: () {
                                      var result = repo.deleteData(
                                          'todos', _todoList![index].id);
                                      getTodo();
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
