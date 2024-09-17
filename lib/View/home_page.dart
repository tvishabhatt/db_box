import 'package:db_box/Controller/DBHelper.dart';
import 'package:db_box/View/Bookmark_page.dart';
import 'package:flutter/material.dart';
import 'package:db_box/Controller/ThemeController.dart';
import 'package:provider/provider.dart';
import '../Model/Todo_model.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final DBHelper _dbHelper = DBHelper();
  List<Todo> _todos = [];
  final TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final todos = await _dbHelper.getTodos();
    setState(() {
      _todos = todos;
    });
  }


  Future<void> _addTodo() async {
    if (taskController.text.isNotEmpty) {
      Todo newTodo = Todo(
        task: taskController.text,
      );
      await _dbHelper.addTodo(newTodo);
      taskController.clear();
      _fetchTodos();
    }
  }

  Future<void> _deleteTodo(int id) async {
    await _dbHelper.deleteTodo(id);
    _fetchTodos();
  }

  Future<void> _toggleFavorite(Todo todo) async {
    Todo updatedTodo = Todo(
      id: todo.id,
      task: todo.task,
      isFavorite: !todo.isFavorite,
    );
    await _dbHelper.updateTodo(updatedTodo);
    _fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    final themeController=Provider.of<ThemeController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page',
            style: (TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        actions: [
          IconButton(
              onPressed: () {
                showAddTaskDialog(context,taskController,_addTodo);
              },
              icon: Icon(Icons.add)),
          IconButton(
              onPressed: () {
                themeController.toggleTheme();
              },
              icon: Icon(themeController.isDarkTheme?Icons.dark_mode:Icons.light)),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BookmarkPage()));
            },
          ),
        ],
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  return Card(
                    color: themeController.isDarkTheme?Colors.red.shade800:Colors.red.shade100,
                    child: ListTile(
                      title: SizedBox(
                          width: double.infinity,
                          child: Text(todo.task.toString())),
                      trailing: SizedBox(
                        width: 145,
                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                todo.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: todo.isFavorite ? Colors.red : null,
                              ),

                              onPressed: () => _toggleFavorite(todo),
                            ),
                            IconButton(
                              icon: Icon(
                              Icons.delete
                              ),

                              onPressed: () => _deleteTodo(todo.id!),
                            ),
                            IconButton(
                              icon: Icon(
                                  Icons.edit
                              ),
                              onPressed: () => _editTodo(todo),

                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showAddTaskDialog(BuildContext context, TextEditingController taskController, Function _addTodo) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'Task'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _addTodo();
                  Navigator.of(context).pop();
                },
                child: Text('Add TODO'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _editTodo(Todo todo) async {
    taskController.text = todo.task;
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: taskController,
                decoration: InputDecoration(labelText: 'Edit Task'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (taskController.text.isNotEmpty) {
                    Todo updatedTodo = Todo(
                      id: todo.id,
                      task: taskController.text,
                      isFavorite: todo.isFavorite,
                    );
                    await _dbHelper.updateTodo(updatedTodo);
                    taskController.clear();
                    Navigator.of(context).pop();
                    _fetchTodos();
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        );
      },
    );
  }


}
