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
  final String id;
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
  final String modified;

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
    this.modified,
    this.onRemoveUserTeam,
    this.onCreate,
    this.onUpdate,
    this.todoCompleted,
    this.todoTotal,
    this.id,
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
      height: double.infinity,
      color: Colors.black45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          row01(),
          row02(),
          // row03(),
          Expanded(child: row03()),
        ],
      ),
    );
  }

  Widget row01() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(flex: 3, child: description()),
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
      "Autor: ${widget.author?.displayName}. Criada em ${widget.created}. Modificada em ${widget.modified}. Id: ${widget.id.substring(0, 5)}\n${widget.description}.",
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
      children: [
        Expanded(flex: 2, child: FeedCardList()),
        Expanded(flex: 1, child: TodoCardList())
      ],
    );
  }
}
