import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/kanban_board_crud.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/quadro_card_widget.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/routes.dart';

class KanbanBoardPage2DS extends StatelessWidget {
  final List<KanbanBoardModel> filteredKanbanBoardModel;
  final Function(String) onCurrentKanbanBoardModel;
  final Function(String, bool) onActive;

  const KanbanBoardPage2DS({
    Key key,
    this.filteredKanbanBoardModel,
    this.onCurrentKanbanBoardModel,
    this.onActive,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quadros"),
      ),
      backgroundColor: PmsbColors.navbar,
      // backToRootPage: true,
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
                RaisedButton(
                  child: Text("Criar novo quadro"),
                  color: PmsbColors.cor_destaque,
                  onPressed: () {
                    onCurrentKanbanBoardModel(null);
                    // Navigator.pushNamed(context, Routes.kanbanBoardCRUD);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KanbanBoardCRUD(),
                      ),
                    );
                  },
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
          child: QuadroCardWidget(
            onViewKanbanCards: () {
              onCurrentKanbanBoardModel(kanbanBoard.id);
              Navigator.pushNamed(context, Routes.kanbanCardPage);
            },
            onEditCurrentKanbanBoardModel: () {
              onCurrentKanbanBoardModel(kanbanBoard.id);
              Navigator.of(context).push(
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
