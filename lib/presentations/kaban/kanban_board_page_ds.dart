import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/components/logout_button.dart';
import 'package:pmsb4/containers/kanban/kanban_board_crud.dart';
import 'package:pmsb4/containers/kanban/kanban_board_filtering.dart';
import 'package:pmsb4/containers/kanban/kanban_card_page.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/presentations/kaban/components/short_board_cds.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/presentations/styles/pmsb_styles.dart';
import 'package:pmsb4/states/types_states.dart';

class KanbanBoardPageDS extends StatelessWidget {
  final List<KanbanBoardModel> filteredKanbanBoardModel;
  final Function(String) onCurrentKanbanBoardModel;
  final Function(String, bool) onActive;
  final KanbanBoardFilter kanbanBoardFilter;

  KanbanBoardPageDS({
    Key key,
    this.filteredKanbanBoardModel,
    this.onCurrentKanbanBoardModel,
    this.onActive,
    this.kanbanBoardFilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [LogoutButton()],
        elevation: 0,
        backgroundColor: PmsbColors.fundo,
        centerTitle: true,
        title: Text("${kanbanBoardFilter.name}"),
      ),
      backgroundColor: PmsbColors.fundo,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 2.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(),
                Container(),
                Row(
                  children: [
                    kanbanBoardFilter.toString() ==
                            KanbanBoardFilter.activeAuthor.toString()
                        ? RaisedButton(
                            child: Text(
                              "Criar novo quadro",
                              style: PmsbStyles.textoPrimario,
                            ),
                            color: PmsbColors.cor_destaque,
                            onPressed: () {
                              onCurrentKanbanBoardModel(null);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => KanbanBoardCRUD(),
                                ),
                              );
                            },
                          )
                        : Container(),
                    SizedBox(width: 5),
                    KanbanFiltering(),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: mainQuadro(context),
        )
      ],
    );
  }

  Widget mainQuadro(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.10,
        vertical: height * 0.01,
      ),
      child: Container(
        //  color: Colors[],
        child: ListView(
          children: <Widget>[
            // textoQuadro("Meus quadros"),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(children: _listaMeusQuadros(context)),
            ),
            //textoQuadro("Meus gerais"),
          ],
        ),
      ),
    );
  }

  Widget textoQuadro(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
          color: PmsbColors.texto_secundario,
          fontSize: 18,
        ),
      ),
    );
  }

  _listaMeusQuadros(BuildContext context) {
    List<Widget> list = List<Widget>();

    for (var kanbanBoard in filteredKanbanBoardModel) {
      list.add(
        Padding(
          padding: EdgeInsets.all(2.0),
          child: ShortBoardCDS(
            kanbanBoardFilter: kanbanBoardFilter,
            onViewKanbanCards: () {
              onCurrentKanbanBoardModel(kanbanBoard.id);
              // Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => KanbanCardPage(),
                ),
              );
            },
            onEditCurrentKanbanBoardModel: () {
              // Navigator.pop(context);
              onCurrentKanbanBoardModel(kanbanBoard.id);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => KanbanBoardCRUD(),
                ),
              );
            },
            cor: PmsbColors.card,
            quadro: kanbanBoard,
            onActive: onActive,
          ),
        ),
      );
    }
    return list;
  }
}
