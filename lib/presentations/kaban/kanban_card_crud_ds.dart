import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_page.dart';
import 'package:pmsb4/containers/kanban/team_card.dart';
import 'package:pmsb4/containers/kanban/todo_card_page.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class KanbanCardCRUDDS extends StatefulWidget {
  final bool isCreate;
  final String title;
  final String description;
  final bool priority;
  final bool active;
  final int todoCompleted;
  final int todoTotal;
  final List<Team> team;
  final Function(String, String, bool, bool) onCreateOrUpdate;
  final Function(String) onRemoveUserTeam;

  const KanbanCardCRUDDS({
    Key key,
    this.isCreate,
    this.title,
    this.description,
    this.priority,
    this.active,
    this.team,
    this.onRemoveUserTeam,
    this.onCreateOrUpdate,
    this.todoCompleted,
    this.todoTotal,
  }) : super(key: key);
  @override
  _KanbanCardCRUDDSState createState() =>
      _KanbanCardCRUDDSState(priority, active);
}

class _KanbanCardCRUDDSState extends State<KanbanCardCRUDDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  bool _priority;
  bool _active;

  _KanbanCardCRUDDSState(this._priority, this._active);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isCreate
            ? Text('KanbanCardCRUD Criar')
            : Text('KanbanCardCRUD Editar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: form(),
      ),
    );
  }

  List<Widget> avatarsTeam() {
    List<Widget> listaWidget = List<Widget>();
    for (var item in widget.team) {
      listaWidget.add(
        InkWell(
          onTap: () {
            // print('removendo user${item.id}');
            widget.onRemoveUserTeam(item.id);
          },
          child: Tooltip(
            message: '${item.displayName} ${item.id.substring(0, 5)}',
            child: Stack(
              children: [
                CircleAvatar(
                  minRadius: 20,
                  maxRadius: 20,
                  child: ClipOval(
                    child: Center(
                      child: item?.photoUrl != null
                          ? Image.network(item.photoUrl)
                          : Icon(Icons.person_add),
                    ),
                  ),
                ),
                Icon(
                  Icons.remove_red_eye,
                  color: item?.readedCard ?? true
                      ? Colors.transparent
                      : Colors.red,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return listaWidget;
  }

  Widget form() {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          InputText(
            title: 'Titulo do card',
            initialValue: widget.title,
            onSaved2: (value) => _title = value,
          ),
          InputText(
            title: 'Descrição do card',
            initialValue: widget.description,
            onSaved2: (value) => _description = value,
          ),
          ListTile(
            title: Text('Prioridade'),
            trailing: Checkbox(
                // +++
                // 1) Ou usa assim true||false never null
                value: _priority,
                // 2) Ou assim true|false|null
                // value: _priority,
                // tristate: true,
                // ---
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                }),
          ),
          ListTile(
            title: Text('Active'),
            trailing: Checkbox(
                // +++
                // 1) Ou usa assim true||false never null
                value: _active ?? false,
                // 2) Ou assim true|false|null
                // value: _public,
                // tristate: true,
                // ---
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _active = value;
                  });
                }),
          ),
          ListTile(
            title: Text('Time atual com ${widget.team.length} membros.'),
            onTap: () {
              // Navigator.pushNamed(context, Routes.usersTeam);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TeamCard(),
                ),
              );
            },
          ),
          Wrap(
            children: avatarsTeam(),
          ),
          ListTile(
            title: Text(
                ' ${widget.todoCompleted}/${widget.todoTotal} ToDos resolvidos.'),
            onTap: () {
              // Navigator.pushNamed(context, Routes.usersTeam);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TodoCardPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Feed de notícias.'),
            onTap: () {
              // Navigator.pushNamed(context, Routes.usersTeam);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FeedCardPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Center(
              child: widget.isCreate ? Text('Criar') : Text('Atualizar'),
            ),
            onTap: () {
              validateData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onCreateOrUpdate(_title, _description, _priority, _active);
    } else {
      setState(() {});
    }
  }
}
