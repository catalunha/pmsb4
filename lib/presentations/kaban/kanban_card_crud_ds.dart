import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/team_card.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class KanbanCardCRUDDS extends StatefulWidget {
  final bool isEditing;
  final String title;
  final String description;
  final bool priority;
  final bool active;
    final List<UserKabanRef> team;

  final Function(String, String,bool,bool) onCreate;
  final Function(String, String,bool,bool) onUpdate;


  const KanbanCardCRUDDS({
    Key key,
    this.isEditing,
    this.title,
    this.description,
    this.priority,
    this.active,
    this.team,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _KanbanCardCRUDDSState createState() => _KanbanCardCRUDDSState(priority,active);
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
        title: widget.isEditing
            ? Text('Kanban Card Editar')
            : Text('Kanban Card Criar'),
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
            // widget.removeUserTeam(item.id);
          },
          child: Tooltip(
            message: item.displayName,
            child: CircleAvatar(
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
            title: Center(
              child: widget.isEditing ? Text('Atualizar') : Text('Criar'),
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
      if (widget.isEditing) {
        widget.onUpdate(_title,_description,_priority,_active);
      } else {
        widget.onCreate(_title,_description,_priority,_active);
      }
    } else {
      setState(() {});
    }
  }
}
