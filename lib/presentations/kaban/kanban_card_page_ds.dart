import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:pmsb4/containers/kanban/kanban_card_crud.dart';
import 'package:pmsb4/containers/kanban/kanban_card_filtering.dart';
import 'package:pmsb4/containers/kanban/kanban_card_page_inactive.dart';
import 'package:pmsb4/containers/kanban/team_card_filtering.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/short_card_cds.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class KanbanCardPageDS extends StatefulWidget {
  final KanbanBoardModel currentKanbanBoardModel;

  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;
  final Function(Map<String, String>) onChangeCardOrder;
  final Function(String, StageCard) onChangeStageCard;

  KanbanCardPageDS({
    Key key,
    this.currentKanbanBoardModel,
    this.filteredKanbanCardModel,
    this.onCurrentKanbanCardModel,
    this.onChangeCardOrder,
    this.onChangeStageCard,
  }) : super(key: key);
  @override
  _KanbanCardPageDSState createState() => _KanbanCardPageDSState();
}

class _KanbanCardPageDSState extends State<KanbanCardPageDS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: PmsbColors.fundo,
        title: Text("Cartões para o ${widget.currentKanbanBoardModel?.title}"),
      ),
      backgroundColor: PmsbColors.fundo,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: width > 1800 ? 15 : 3),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width > 1800 ? (width * 0.10) : (width * 0.01),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.currentKanbanBoardModel?.description,
                  style: TextStyle(
                      fontSize: 18, color: PmsbColors.texto_terciario),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: CircleAvatar(
                        backgroundColor: PmsbColors.navbar,
                        child: TeamCardFiltering(),
                        // child: botaoMore(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: CircleAvatar(
                        backgroundColor: PmsbColors.navbar,
                        child: KanbanCardFiltering(),
                        // child: botaoMore(),
                      ),
                    ),
                    InkWell(
                      child: Tooltip(
                        message: "Ver cartões arquivados",
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("userAvatarUrl"),
                          backgroundColor: PmsbColors.navbar,
                          child: Icon(
                            Icons.archive,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KanbanCardPageInactive(),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width > 1800 ? (width * 0.5) : (width * 0.01),
            ),
            child: Container(
              color: Colors.white12,
              height: 2,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            // child: Padding(
            //   padding: EdgeInsets.symmetric(
            //     horizontal: width > 1800 ? (width * 0.05) : (width * 0.01),
            //   ),
            child: _listaColunas(context, width),
            // ),
          ),
        ],
      ),
    );
  }

  Widget _listaColunas(BuildContext context, double screenWidth) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _listaColuna(context),
        ),
      ),
    );
  }

  List<Widget> _listaColuna(context) {
    List<StageCard> stageCardList = StageCard.values;
    List<Widget> lista = List<Widget>();
    int index = 0;
    stageCardList.forEach((element) {
      index = stageCardList.indexOf(element);
      lista.add(_gerarColuna(context, stageCardList[index]));
    });
    return lista;
  }

  Widget _gerarColuna(BuildContext context, StageCard indexStage) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: width > 1800 ? 300 : 260,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    offset: Offset(0, 0),
                    color: Color.fromRGBO(127, 140, 141, 0.5),
                    spreadRadius: 1)
              ],
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(width > 1800 ? 12 : 5),
            height: MediaQuery.of(context).size.height * 0.8,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        indexStage.name,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      indexStage.toString() == StageCard.todo.toString()
                          ? IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.blueGrey,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      KanbanCardCRUD(
                                    id: null,
                                  ),
                                );
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.transparent,
                              ),
                              onPressed: () {},
                            ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: DragAndDropList<KanbanCardModel>(
                        widget.filteredKanbanCardModel,
                        itemBuilder: (BuildContext context,
                            KanbanCardModel kanbanCardModel) {
                          if (kanbanCardModel.stageCard ==
                              indexStage.toString()) {
                            return kanbanCard(
                                kanbanCardModel, indexStage.toString());
                          } else {
                            return Container();
                          }
                        },
                        onDragFinish: (oldIndex, newIndex) {
                          //print('oldIndex:$oldIndex, newIndex:$newIndex');

                          setState(() {
                            KanbanCardModel todo =
                                widget.filteredKanbanCardModel[oldIndex];
                            widget.filteredKanbanCardModel.removeAt(oldIndex);
                            widget.filteredKanbanCardModel
                                .insert(newIndex, todo);
                            onChangeCardOrderPush();
                          });
                        },
                        canBeDraggedTo: (one, two) => true,
                        dragElevation: 8.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: DragTarget<dynamic>(
              onWillAccept: (data) {
                // print(data);
                return true;
              },
              onLeave: (data) {},
              onAccept: (data) {
                print(
                    'DragTarget.onAccept ${data["kanbanCardDraggable"].id} from ${data["oldStage"]} to ${indexStage.toString()}');
                if (data['oldStage'] == indexStage.toString()) {
                  return;
                }
                int indexOf = widget.filteredKanbanCardModel
                    .indexOf(data["kanbanCardDraggable"]);

                setState(() {
                  widget.filteredKanbanCardModel[indexOf].stageCard =
                      indexStage.toString();
                  widget.onChangeStageCard(
                      widget.filteredKanbanCardModel[indexOf].id, indexStage);
                  // +++ tire o elemento de onde esta e coloca no topo da list do destino
                  int indexFirstStage = widget.filteredKanbanCardModel.indexOf(
                      widget.filteredKanbanCardModel.firstWhere((element) =>
                          element.stageCard == indexStage.toString()));

                  KanbanCardModel todo =
                      widget.filteredKanbanCardModel[indexOf];
                  widget.filteredKanbanCardModel.removeAt(indexOf);
                  widget.filteredKanbanCardModel.insert(indexFirstStage, todo);
                  // ---
                  onChangeCardOrderPush();
                });
              },
              builder: (context, accept, reject) {
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  void onChangeCardOrderPush() {
    var index = 1;
    Map<String, String> cardOrder = Map.fromIterable(
        widget.filteredKanbanCardModel,
        key: (e) => (index++).toString(),
        value: (e) => e.id);
    widget.onChangeCardOrder(cardOrder);
  }

  Widget kanbanCard(KanbanCardModel kanbanCard, String oldStage) {
    return Container(
      key: ValueKey(kanbanCard),
      width: MediaQuery.of(context).size.width > 1800 ? 300 : 250.0,
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Draggable<dynamic>(
        feedback: Material(
          elevation: 5.0,
          child: Container(
            width: MediaQuery.of(context).size.width > 1800 ? 295 : 245.0,
            padding: EdgeInsets.all(16.0),
            color: PmsbColors.card,
            child: Text('${kanbanCard.title}'),
          ),
        ),
        childWhenDragging: Container(),
        child: ShortCardCDS(
          arquivado: false,
          onTap: () {
            widget.onCurrentKanbanCardModel(kanbanCard.id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => KanbanCardCRUD(
                  id: kanbanCard.id,
                ),
              ),
            );
          },
          tarefa: kanbanCard,
          cor: PmsbColors.card,
        ),
        data: {'kanbanCardDraggable': kanbanCard, 'oldStage': oldStage},
      ),
    );
  }
}
