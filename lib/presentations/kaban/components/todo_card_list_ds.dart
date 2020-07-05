import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/todo_card_crud.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class TodoCardListDS extends StatefulWidget {
  final List<Todo> listTodo;
  final Function(String) onDelete;
  final Function(String) onChangeComplete;
  final Function(Map<String, String>) onChangeTodoOrder;

  TodoCardListDS(
      {Key key,
      this.listTodo,
      this.onDelete,
      this.onChangeComplete,
      this.onChangeTodoOrder})
      : super(key: key);

  @override
  _TodoCardListDSState createState() => _TodoCardListDSState();
}

class _TodoCardListDSState extends State<TodoCardListDS> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textoQuadro("Ações"),
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                TodoCardCRUD(id: null);
                showDialog(
                  context: context,
                  builder: (BuildContext context) => TodoCardCRUD(
                    id: null,
                  ),
                );
              },
            ),
          ],
        ),
        Container(
          width: 500,
          height: 500,
          //  width : MediaQuery.of(context).size.width;
          //  height : MediaQuery.of(context).size.height;
          child: ReorderableListView(
            scrollDirection: Axis.vertical,
            children: buildItens(),
            onReorder: _onReorder,
          ),
        ),
        // Column(
        //   // children: gerarListaAcoesWidgets(),
        //   children: buildItens(),
        // ),
      ],
    );
  }

  Widget textoQuadro(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
          color: PmsbColors.texto_secundario,
          fontSize: 18,
        ),
      ),
    );
  }

  List<Widget> gerarListaAcoesWidgets() {
    List<Widget> lista = List<Widget>();
    for (Todo acao in widget.listTodo) {
      lista.add(
        CheckboxListTile(
          value: acao.complete,
          title: Text(acao.title),
          onChanged: (bool newValue) {
            setState(() {
              widget.onChangeComplete(acao.id);
              setState(() {});
            });
          },
          secondary: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              widget.onDelete(acao.id);
              setState(() {});
            },
          ),
        ),
      );
    }
    return lista;
  }

  buildItens() {
    List<Widget> list = [];
    int i = 1;
    for (var todo in widget.listTodo) {
      list.add(ListTile(
        key: ValueKey(todo),
        title: Text(todo.title),
        // subtitle: Text('id:${todo.id} | order:${i++}'),
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
          showDialog(
            context: context,
            builder: (BuildContext context) => TodoCardCRUD(
              id: todo.id,
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
      Todo todo = widget.listTodo[oldIndex];
      widget.listTodo.removeAt(oldIndex);
      widget.listTodo.insert(newIndex, todo);
    });
    var index = 1;
    Map<String, String> todoOrder = Map.fromIterable(widget.listTodo,
        key: (e) => (index++).toString(), value: (e) => e.id);
    widget.onChangeTodoOrder(todoOrder);
  }
}
