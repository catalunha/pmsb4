import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_list.dart';
import 'package:pmsb4/containers/kanban/kanban_card_page.dart';
import 'package:pmsb4/containers/kanban/todo_card_list.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/team_card_add_cds.dart';
import 'package:pmsb4/presentations/kaban/kanban_card_create_update_title_ds.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class KanbanCardCreateUpdateOtherDS extends StatefulWidget {
  final bool isCreate;
  final Team author;
  final String title;
  final String description;
  final bool priority;
  final bool active;
  final int todoCompleted;
  final int todoTotal;
  final int number;
  final String created;

  final List<Team> team;
  final Function(String, String, bool, bool) onCreate;
  final Function(String, String, bool, bool) onUpdate;
  final Function(String) onRemoveUserTeam;

  const KanbanCardCreateUpdateOtherDS({
    Key key,
    this.isCreate,
    this.author,
    this.title,
    this.description,
    this.priority,
    this.active,
    this.team,
    this.number,
    this.created,
    this.onRemoveUserTeam,
    this.onCreate,
    this.onUpdate,
    this.todoCompleted,
    this.todoTotal,
  }) : super(key: key);
  @override
  _KanbanCardCreateUpdateOtherDSState createState() =>
      _KanbanCardCreateUpdateOtherDSState();
}

class _KanbanCardCreateUpdateOtherDSState
    extends State<KanbanCardCreateUpdateOtherDS> {
  bool _priority;
  ScrollController scrowllController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrowllController = ScrollController();
    _priority = widget.priority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: PmsbColors.fundo,
        elevation: 0,
        title: Text("#${widget.number} - ${widget.title}"),
      ),
      backgroundColor: PmsbColors.fundo,
      body: Center(child: body()),
    );
  }

  Widget body() {
    double width = MediaQuery.of(context).size.width;
    double widthPage = width > 1800 ? (width * 0.8) : width * 0.97;

    return Container(
      width: widthPage,
      color: Colors.black45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          row01(),
          row02(),
          row03(),
        ],
      ),
    );

    // return Scrollbar(
    //   controller: scrowllController,
    //   isAlwaysShown: true,
    //   child: Center(
    //     child: Container(
    //       width: widthPage,
    //       color: Colors.black12,
    //       child: ListView(
    //         children: <Widget>[
    //           // _descricao(),
    //           // _painel(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget row01() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 4, child: description()),
        Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                edit(),
                arquive(),
              ],
            ))
      ],
    );
  }

  Widget description() {
    return Text(
      "Autor: ${widget.author?.displayName}. Criada em ${widget.created}. Id: \n${widget.description}.",
      style: TextStyle(
        color: PmsbColors.texto_terciario,
        fontSize: 14,
      ),
    );
  }

  Widget edit() {
    return RaisedButton.icon(
      color: Colors.transparent,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => KanbanCardCreateUpdateTitleDS(
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
    );
  }

  Widget arquive() {
    return RaisedButton.icon(
      label: Text("Arquivar"),
      color: Colors.transparent,
      onPressed: () {
        widget.onUpdate(null, null, null, false);
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => KanbanCardPage(),
          ),
        );
      },
      icon: Icon(Icons.archive),
      elevation: 0,
      disabledElevation: 0,
      disabledColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }

  Widget row02() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 2, child: team()),
        Expanded(flex: 1, child: priority())
      ],
    );
  }

  Widget team() {
    return TeamCardAddCDS(
        team: widget.team, onRemoveUserTeam: widget.onRemoveUserTeam);
  }

  Widget priority() {
    return SwitchListTile(
      value: _priority,
      title: Text('Esta tarefa é prioridade ?'),
      subtitle: _priority
          ? Text('A prioridade desta tarefa é maior.',
              style: TextStyle(color: Colors.yellow))
          : Text('Atendimento normal.'),
      onChanged: (value) {
        widget.onUpdate(null, null, value, null);
        setState(
          () {
            _priority = value;
          },
        );
      },
    );
  }

  Widget row03() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Expanded(flex: 2, child: FeedCardList()),
        Expanded(flex: 1, child: TodoCardList())
      ],
    );
  }

// velhos...
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
                      "Autor: ${widget.author?.displayName}. Criada em ${widget.created}. Id: \n${widget.description}.",
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
                              KanbanCardCreateUpdateTitleDS(
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
                      label: Text("Arquivar"),
                      color: Colors.transparent,
                      onPressed: () {
                        widget.onUpdate(null, null, null, false);
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KanbanCardPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.archive),
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
                  //height: 115,
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
                  child: Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: ListTile(
                      title: textoTitulo('Esta tarefa é prioridade ?'),
                      subtitle: _priority
                          ? textoSubtitulo(
                              'A prioridade desta tarefa é alta sobre as demais.',
                              color: Colors.yellow)
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

  Widget textoSubtitulo(String texto,
      {Color color = PmsbColors.texto_terciario}) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
          color: color,
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
