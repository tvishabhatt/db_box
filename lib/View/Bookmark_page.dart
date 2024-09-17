import 'package:db_box/Controller/DBHelper.dart';
import 'package:db_box/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/Todo_model.dart';


class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  final DBHelper _dbHelper = DBHelper();
  List<Todo> _favoriteTodos = [];

  @override
  void initState() {
    super.initState();
    _fetchFavoriteTodos();
  }

  Future<void> _fetchFavoriteTodos() async {
    final todos = await _dbHelper.getTodos();
    setState(() {
      _favoriteTodos = todos.where((todo) => todo.isFavorite).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController=Provider.of<ThemeController>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Bookmarked TODOs'),
      ),
      body: _favoriteTodos.isEmpty
          ? Center(child: Text('No bookmarked TODOs'))
          : ListView.builder(
        itemCount: _favoriteTodos.length,
        itemBuilder: (context, index) {
          final todo = _favoriteTodos[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color:  themeController.isDarkTheme?Colors.red.shade800:Colors.red.shade100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(todo.task),
              ),

            ),
          );
        },
      ),
    );
  }
}