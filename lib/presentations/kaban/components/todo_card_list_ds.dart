import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/todo_card_crud.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/todo_card_create_ds.dart';
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
                }),
          ],
        ),
        Column(
          children: gerarListaAcoesWidgets(),
        ),
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
      lista.add(CheckboxListTile(
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
            }),
      ));
    }
    return lista;
  }
}
