import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:pmsb4/containers/kanban/kanban_card_crud.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/tarefa_card_widget.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

// import 'package:pmsbmibile3/naosuportato/url_launcher.dart'
//     if (dart.library.io) 'package:url_launcher/url_launcher.dart';

class KanbanCardPage2DS extends StatefulWidget {
  final KanbanBoardModel currentKanbanBoardModel;

  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;
  final Function(Map<String, String>) onChangeCardOrder;
  final Function(String, String) onChangeStageCard;

  KanbanCardPage2DS({
    Key key,
    this.currentKanbanBoardModel,
    this.filteredKanbanCardModel,
    this.onCurrentKanbanCardModel,
    this.onChangeCardOrder,
    this.onChangeStageCard,
  }) : super(key: key);
  @override
  _KanbanCardPage2DSState createState() => _KanbanCardPage2DSState();
}

class _KanbanCardPage2DSState extends State<KanbanCardPage2DS> {
  List<String> stages = [
    StageCard.story.toString(),
    StageCard.todo.toString(),
    StageCard.doing.toString(),
    StageCard.check.toString(),
    StageCard.done.toString(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cartões para o ${widget.currentKanbanBoardModel?.title}"),
      ),
      backgroundColor: PmsbColors.navbar,
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
                    InkWell(
                      child: Tooltip(
                        message: "Filtrar por equipe",
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("userAvatarUrl"),
                          backgroundColor: PmsbColors.navbar,
                          child: Icon(
                            Icons.supervised_user_circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => null,
                          // ListaUsuariosModal(
                          //   selecaoMultipla: false,
                          // ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: CircleAvatar(
                        backgroundColor: PmsbColors.navbar,
                        child: botaoMore(),
                      ),
                    ),
                    InkWell(
                      child: Tooltip(
                        message: "Tarefas arquivadas",
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => (TarefasArquivadasPage(
                        //       tarefa: tarefa01,
                        //     )),
                        //   ),
                        // );
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
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width > 1800 ? (width * 0.05) : (width * 0.01),
              ),
              child: _listaColunas(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget botaoMore() {
    return PopupMenuButton<Function>(
      color: PmsbColors.navbar,
      tooltip: "Filtrar por prioridade",
      icon: Icon(
        Icons.group_work,
        color: Colors.white,
      ),
      onSelected: (Function result) {
        result();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
        PopupMenuItem<Function>(
          value: () {
            // Filtrar mostrando todos
          },
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.brightness_1,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text('Listar todos'),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<Function>(
          value: () {
            // Listar por prioridade alta
          },
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.brightness_1,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text('Prioridade alta'),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<Function>(
          value: () {
            // Listar por prioridade baixa
          },
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.brightness_1,
                color: Colors.green,
              ),
              SizedBox(width: 5),
              Text('Prioridade baixa'),
              SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _listaColunas(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stages.length,
        itemBuilder: (context, indexStage) {
          return _gerarColuna(context, indexStage);
        },
      ),
    );
  }

  Widget _gerarColuna(BuildContext context, int indexStage) {
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
                        stages[indexStage],
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blueGrey,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: DragAndDropList<KanbanCardModel>(
                        widget.filteredKanbanCardModel,
                        itemBuilder: (BuildContext context,
                            KanbanCardModel kanbanCardModel) {
                          if (kanbanCardModel.stageCard == stages[indexStage]) {
                            return kanbanCard(
                                kanbanCardModel, stages[indexStage]);
                          } else {
                            return Container();
                          }
                        },
                        onDragFinish: (oldIndex, newIndex) {
                          print('oldIndex:$oldIndex, newIndex:$newIndex');

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
                    'DragTarget.onAccept ${data["kanbanCardDraggable"].id} from ${data["oldStage"]} to ${stages[indexStage]}');
                if (data['oldStage'] == stages[indexStage]) {
                  return;
                }
                int indexOf = widget.filteredKanbanCardModel
                    .indexOf(data["kanbanCardDraggable"]);

                setState(() {
                  widget.filteredKanbanCardModel[indexOf].stageCard =
                      stages[indexStage];
                  widget.onChangeStageCard(
                      widget.filteredKanbanCardModel[indexOf].id,
                      stages[indexStage]);
                  // +++ tire o elemento de onde esta e coloca no topo da list do destino
                  int indexFirstStage = widget.filteredKanbanCardModel.indexOf(
                      widget.filteredKanbanCardModel.firstWhere((element) =>
                          element.stageCard == stages[indexStage]));

                  KanbanCardModel todo =
                      widget.filteredKanbanCardModel[indexOf];
                  widget.filteredKanbanCardModel.removeAt(indexOf);
                  widget.filteredKanbanCardModel.insert(indexFirstStage, todo);
                  // ---
                  onChangeCardOrderPush();

                  // var index = 1;
                  // Map<String, String> cardOrder = Map.fromIterable(
                  //     widget.filteredKanbanCardModel,
                  //     key: (e) => (index++).toString(),
                  //     value: (e) => e.id);
                  // widget.onChangeCardOrder(cardOrder);
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
        child: TarefaCardWidget(
          arquivado: false,
          onTap: () {
            widget.onCurrentKanbanCardModel(kanbanCard.id);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => KanbanCardCRUD(),
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
