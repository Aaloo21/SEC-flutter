import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoItem> _todoItems = [];

  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add(TodoItem(task));
    });
  }

  void _toggleTodoItem(int index) {
    setState(() {
      _todoItems[index].isCompleted = !_todoItems[index].isCompleted;
    });
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jeevansh's To-do List"),
        backgroundColor: Color.fromARGB(255, 247, 77, 65),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: _todoItems[index].isCompleted,
              onChanged: (bool? value) {
                _toggleTodoItem(index);
              },
            ),
            title: Text(
              _todoItems[index].task,
              style: TextStyle(
                decoration: _todoItems[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeTodoItem(index);
              },
            ),
            onTap: () {
              _toggleTodoItem(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String newTask = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('New To-do'),
                content: TextField(
                  autofocus: true,
                  onSubmitted: (task) {
                    Navigator.pop(context, task);
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );

          if (newTask != null) {
            _addTodoItem(newTask);
          }
        },
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoItem {
  String task;
  bool isCompleted;

  TodoItem(this.task, {this.isCompleted = false});
}

