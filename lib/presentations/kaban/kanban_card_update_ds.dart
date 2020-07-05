import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_list.dart';
import 'package:pmsb4/containers/kanban/todo_card_list.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/team_card_add_cds.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_create_or_update_title_description.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class KanbanCardUpdateDS extends StatefulWidget {
  final bool isCreate;
  final String title;
  final String description;
  final bool priority;
  final bool active;
  final int todoCompleted;
  final int todoTotal;
  final List<Team> team;
  final Function(String, String, bool, bool) onCreate;
  final Function(String, String, bool, bool) onUpdate;
  final Function(String) onRemoveUserTeam;

  const KanbanCardUpdateDS({
    Key key,
    this.isCreate,
    this.title,
    this.description,
    this.priority,
    this.active,
    this.team,
    this.onRemoveUserTeam,
    this.onCreate,
    this.onUpdate,
    this.todoCompleted,
    this.todoTotal,
  }) : super(key: key);
  @override
  _KanbanCardUpdateDSState createState() => _KanbanCardUpdateDSState();
}

class _KanbanCardUpdateDSState extends State<KanbanCardUpdateDS> {
  bool _priority;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _priority = widget.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title}"),
      ),
      backgroundColor: PmsbColors.navbar,
      body: body(),
    );
  }

  Widget body() {
    double width = MediaQuery.of(context).size.width;
    double widthPage = width > 1800 ? (width * 0.8) : (width * 0.95);

    return
        // Scrollbar(
        //   controller: scrowllController,
        //   isAlwaysShown: true,
        //   child: Center(
        //     child:
        Container(
      width: widthPage,
      color: Colors.black12,
      child: ListView(
        children: <Widget>[
          _descricao(),
          _painel(),
        ],
      ),
      //   ),
      // ),
    );
  }

  Widget _descricao() {
    double width = MediaQuery.of(context).size.width;
    double widthPage = width > 1800 ? (width * 0.7) : (width * 0.6);

    return Container(
      color: Colors.black12,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    width: widthPage,
                    child: Text(
                      "${widget.description}",
                      style: TextStyle(
                          color: PmsbColors.texto_terciario, fontSize: 14),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 3),
                    RaisedButton.icon(
                      color: Colors.transparent,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              KanbanCardCreateOrUpdateTitleDescriptionDS(
                            isCreate: false,
                            title: widget.title,
                            description: widget.description,
                            onUpdate: widget.onUpdate,
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                      label: Text("Editar"),
                      elevation: 0,
                      disabledElevation: 0,
                      disabledColor: Colors.transparent,
                      focusColor: Colors.transparent,
                    ),
                    SizedBox(width: 3),
                    RaisedButton.icon(
                      color: Colors.transparent,
                      onPressed: () {
                        widget.onUpdate(null, null, null, false);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.archive),
                      label: Text("Arquivar"),
                      elevation: 0,
                      disabledElevation: 0,
                      disabledColor: Colors.transparent,
                      focusColor: Colors.transparent,
                    ),
                    SizedBox(width: 3),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Container(
                  height: 115,
                  // color: Color(0xFF77869c),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: TeamCardAddCDS(
                        team: widget.team,
                        onRemoveUserTeam: widget.onRemoveUserTeam),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Expanded(
                child: Container(
                  height: 115,
                  // color: Color(0xFF77869c),
                  child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    // child: SwitchListTile(
                    //   dense: true,
                    //   isThreeLine: true,
                    //   subtitle: _priority
                    //       ? Text('A prioridade desta tarefa é alta')
                    //       : Text('Atendimento normal. Sem prioridade.'),
                    //   title: Text('Prioridade'),
                    //   value: _priority,
                    //   onChanged: (value) {
                    //     widget.onUpdate(null, null, value, null);
                    //     setState(
                    //       () {
                    //         _priority = value;
                    //       },
                    //     );
                    //   },
                    // ),
                    child: ListTile(
                      title: textoTitulo('Esta tarefa é prioridade.'),
                      subtitle: _priority
                          ? textoSubtitulo(
                              'A prioridade desta tarefa é alta sobre as demais.')
                          : textoSubtitulo(
                              'Atendimento normal. Sem prioridade sobre as demais.'),
                      leading: Checkbox(
                        value: _priority,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          widget.onUpdate(null, null, value, null);
                          setState(
                            () {
                              _priority = value;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 3,
              ),
            ],
          ),
          //SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget textoTitulo(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
            color: PmsbColors.texto_primario,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget textoSubtitulo(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
          color: PmsbColors.texto_terciario,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget _painel() {
    return Container(
      // color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(child: FeedCardList(), flex: 7),
          SizedBox(
            width: 1,
          ),
          Flexible(child: _colunaOpcoes(), flex: 3),
        ],
      ),
    );
  }

  Widget _colunaOpcoes() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            color: Color(0xFF77869c),
            child: Padding(
              padding: EdgeInsets.only(top: 2),
              child: TodoCardList(),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
