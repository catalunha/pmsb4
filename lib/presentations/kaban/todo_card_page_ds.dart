import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/todo_card_crud.dart';
import 'package:pmsb4/models/types_models.dart';

class TodoCardPageDS extends StatefulWidget {
  final List<Todo> listTodo;
  final Function(String) onDelete;
  final Function(String) onChangeComplete;
  final Function(Map<String, String>) onChangeTodoOrder;

  TodoCardPageDS(
      {Key key,
      this.listTodo,
      this.onDelete,
      this.onChangeComplete,
      this.onChangeTodoOrder})
      : super(key: key) {
    print('atualizado........................................');
  }

  @override
  _TodoCardPageDSState createState() => _TodoCardPageDSState(listTodo);
}

class _TodoCardPageDSState extends State<TodoCardPageDS> {
  List<Todo> _listTodo = [];

  _TodoCardPageDSState(this._listTodo);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TodoCardPage'),
      ),
      body: ReorderableListView(
        scrollDirection: Axis.vertical,
        children: buildItens(),
        onReorder: _onReorder,
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

  buildItens() {
    List<Widget> list = [];
    int i = 1;
    for (var todo in _listTodo) {
      list.add(ListTile(
        key: ValueKey(todo),
        title: Text(todo.title),
        subtitle: Text('id:${todo.id} | order:${i++}'),
        leading: Checkbox(
          value: todo.complete,
          onChanged: (value) {
            widget.onChangeComplete(todo.id);
            setState(() {});
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            widget.onDelete(todo.id);
            setState(() {});
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoCardCRUD(
                id: todo.id,
              ),
            ),
          );
        },
      ));
    }
    return list;
  }

  void _onReorder(int oldIndex, int newIndex) {
    print('oldIndex:$oldIndex | newIndex:$newIndex');
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    setState(() {
      Todo todo = _listTodo[oldIndex];
      _listTodo.removeAt(oldIndex);
      _listTodo.insert(newIndex, todo);
    });
    var index = 1;
    Map<String, String> orderTodo = Map.fromIterable(_listTodo,
        key: (e) => (index++).toString(), value: (e) => e.id);
    widget.onChangeTodoOrder(orderTodo);
  }
}
