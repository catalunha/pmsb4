import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/users_team.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class KanbanBoardCRUDDS extends StatefulWidget {
  final bool isEditing;
  final String title;
  final String description;
  final bool public;
  final bool active;
  final List<UserKabanRef> team;

  final Function(String, String, bool, bool) create;
  final Function(String, String, bool, bool) update;

  const KanbanBoardCRUDDS({
    Key key,
    this.isEditing,
    this.title,
    this.description,
    this.public,
    this.active,
    this.team,
    this.create,
    this.update,
  }) : super(key: key);
  @override
  KanbanBoardCRUDDSState createState() {
    return KanbanBoardCRUDDSState(public, active);
  }
}

class KanbanBoardCRUDDSState extends State<KanbanBoardCRUDDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  bool _public;
  bool _active;

  KanbanBoardCRUDDSState(this._public, this._active);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing
            ? Text('Kanban Board Editar')
            : Text('Kanban Board Criar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: form(),
      ),
    );
  }

  List<Widget> avatars() {
    List<Widget> listaWidget = List<Widget>();
    for (var item in widget.team) {
      listaWidget.add(CircleAvatar(
        minRadius: 20,
        maxRadius: 20,
        child: ClipOval(
          child: Center(
            child: item?.photoUrl != null
                ? Image.network(item.photoUrl)
                : Icon(Icons.chat),
          ),
        ),
      ));
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
            title: 'Titulo do quadro',
            initialValue: widget.title,
            onSaved2: (value) => _title = value,
          ),
          InputText(
            title: 'Descrição do quadro',
            initialValue: widget.description,
            onSaved2: (value) => _description = value,
          ),
          ListTile(
            title: Text('Public'),
            trailing: Checkbox(
                // +++
                // 1) Ou usa assim true||false never null
                value: _public,
                // 2) Ou assim true|false|null
                // value: _public,
                // tristate: true,
                // ---
                activeColor: Colors.green,
                onChanged: (value) {
                  setState(() {
                    _public = value;
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
            title: Text('Incluir time ${widget.team.length}'),
            onTap: () {
              // Navigator.pushNamed(context, Routes.usersTeam);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => UsersTeam(),
                ),
              );
            },
          ),
          Wrap(
            children: avatars(),
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
        widget.update(_title, _description, _public, _active);
      } else {
        widget.create(_title, _description, _public, _active);
      }
    } else {
      setState(() {});
    }
  }
}
