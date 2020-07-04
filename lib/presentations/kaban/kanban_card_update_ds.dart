import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_list.dart';
import 'package:pmsb4/containers/kanban/todo_card_list.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/equipe_wrap_cds.dart';
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
  ScrollController scrowllController = new ScrollController();

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

    return Scrollbar(
      controller: scrowllController,
      isAlwaysShown: true,
      child: Center(
        child: Container(
          width: widthPage,
          color: Colors.black12,
          child: ListView(
            children: <Widget>[
              _descricao(),
              _painel(),
            ],
          ),
        ),
      ),
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
                        print("editar titulo e descricao");
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
                        print("arquivar card. ainda nao implementado");
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
                    child: EquipeWrapCDS(
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
                      padding: EdgeInsets.only(top: 2), child: Container()
                      // EtiquetaWrapWidget(etiquetas: widget.tarefa.etiquetas),
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
