import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/todo_card_crud.dart';
import 'package:pmsb4/models/kaban_card_model.dart';

class TodoCardPageDS extends StatelessWidget {
  final List<Todo> listTodo;
  final Function(String) onDelete;
  final Function(String) onChangeComplete;

  const TodoCardPageDS(
      {Key key, this.listTodo, this.onDelete, this.onChangeComplete})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoCardPage'),
      ),
      body: ListView.builder(
        itemCount: listTodo.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = listTodo[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(todo.title),
                  subtitle: Text(todo.id),
                  leading: Checkbox(
                    value: todo.complete,
                    onChanged: (value) {
                      onChangeComplete(todo.id);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onDelete(todo.id);
                    },
                  ),
                  onTap: (){
                    Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoCardCRUD(
                id: todo.id,
              ),
            ),
          );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TodoCardCRUD(
                  id: null,
                ),
              ),
            );
          }),
    );
  }
}
