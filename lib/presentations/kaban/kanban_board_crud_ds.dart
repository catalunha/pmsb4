import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/team_board.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/components/input_text.dart';

class KanbanBoardCRUDDS extends StatefulWidget {
  final bool isCreate;
  final String title;
  final String description;
  final bool public;
  final bool active;
  final List<Team> team;
  final Function(String) onRemoveUserTeam;
  final Function(String, String, bool, bool) onCreateOrUpdate;

  const KanbanBoardCRUDDS(
      {Key key,
      this.isCreate,
      this.title,
      this.description,
      this.public,
      this.active,
      this.team,
      this.onCreateOrUpdate,
      this.onRemoveUserTeam})
      : super(key: key);
  @override
  KanbanBoardCRUDDSState createState() {
    return KanbanBoardCRUDDSState();
    // return KanbanBoardCRUDDSState(public, active);
  }
}

class KanbanBoardCRUDDSState extends State<KanbanBoardCRUDDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  bool _public;
  bool _active;

  // KanbanBoardCRUDDSState() {
  //   // KanbanBoardCRUDDSState(this._public, this._active) {
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _public = widget.public;
    _active = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isCreate
            ? Text('Kanban Board Criar')
            : Text('Kanban Board Editar'),
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
            print('removendo user${item.id}');
            widget.onRemoveUserTeam(item.id);
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
          // ListTile(
          //   title: Text('Active'),
          //   trailing: Checkbox(
          //       // +++
          //       // 1) Ou usa assim true||false never null
          //       value: _active ?? false,
          //       // 2) Ou assim true|false|null
          //       // value: _public,
          //       // tristate: true,
          //       // ---
          //       activeColor: Colors.green,
          //       onChanged: (value) {
          //         _active = value;
          //         setState(() {});
          //       }),
          // ),
          ListTile(
            title: Text('Time atual com ${widget.team.length} membros.'),
            onTap: () {
              // Navigator.pushNamed(context, Routes.usersTeam);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TeamBoard(),
                ),
              );
            },
          ),
          Wrap(
            children: avatarsTeam(),
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
      widget.onCreateOrUpdate(_title, _description, _public, _active);
    } else {
      setState(() {});
    }
  }
}
