import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_list_drag_and_drop/drag_and_drop_list.dart';
import 'package:pmsb4/containers/kanban/kanban_card_crud.dart';
import 'package:pmsb4/containers/kanban/kanban_card_filtering.dart';
import 'package:pmsb4/containers/kanban/team_card_filtering.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';

class KanbanCardPageDS extends StatefulWidget {
  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;

  const KanbanCardPageDS(
      {Key key, this.filteredKanbanCardModel, this.onCurrentKanbanCardModel})
      : super(key: key);

  @override
  _KanbanCardPageDSState createState() => _KanbanCardPageDSState();
}

class _KanbanCardPageDSState extends State<KanbanCardPageDS> {
  List<String> stages = [
    "StageCard.story",
    "StageCard.todo",
    "StageCard.doing",
    "StageCard.check",
    "StageCard.done",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Kanban Card Page ${widget.filteredKanbanCardModel.length}'),
        actions: [
          KanbanCardFiltering(),
          TeamCardFiltering(),
        ],
      ),
      // body: ListView(
      //   children: listCard(widget.filteredKanbanCardModel),
      // ),
      body: Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: stages.length,
          itemBuilder: (context, index) {
            return buildStages(index);
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          widget.onCurrentKanbanCardModel(null);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => KanbanCardCRUD(),
            ),
          );
        },
      ),
    );
  }

  Container buildStages(int index) {
    print('buildStages: $index');
    return Container(
      child: Stack(
        children: [
          Container(
            width: 200.0,
            height: MediaQuery.of(context).size.height * 0.8,
            color: Colors.yellow,
            margin: EdgeInsets.all(6.0),
            child: Column(
              children: [
                Text(stages[index]),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: DragAndDropList<KanbanCardModel>(
                      widget.filteredKanbanCardModel,
                      itemBuilder: (BuildContext context,
                          KanbanCardModel kanbanCardModel) {
                        if (kanbanCardModel.stageCard == stages[index]) {
                          return kanbanCard(kanbanCardModel, stages[index]);
                        } else {
                          return Container();
                        }
                      },
                      onDragFinish: (oldIndex, newIndex) {
                        if (newIndex > oldIndex) {
                          newIndex -= 1;
                        }
                        setState(() {
                          KanbanCardModel todo =
                              widget.filteredKanbanCardModel[oldIndex];
                          widget.filteredKanbanCardModel.removeAt(oldIndex);
                          widget.filteredKanbanCardModel.insert(newIndex, todo);
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
          Positioned.fill(
            child: DragTarget<dynamic>(
              onWillAccept: (data) {
                // print('DragTarget.onWillAccept');
                // print('DragTarget.data ${data.kanbanCardDraggable.id}');
                return true;
              },
              onLeave: (data) {
                // print('DragTarget.data ${data}');
                print('DragTarget.onLeave');
              },
              onAccept: (data) {
                print(
                    'DragTarget.onAccept ${data["kanbanCardDraggable"].id} from ${data["newStage"]} to ${stages[index]}');
                if (data['newStage'] == stages[index]) {
                  return;
                }
                int indexK = widget.filteredKanbanCardModel
                    .indexOf(data["kanbanCardDraggable"]);

                setState(() {
                  widget.filteredKanbanCardModel[indexK].stageCard =
                      stages[index];
                });
              },
              builder: (context, accept, reject) {
                print('DragTarget.data ?');
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget kanbanCard(KanbanCardModel kanbanCard, String newStage) {
    return Container(
      key: ValueKey(kanbanCard),
      width: 200.0,
      margin: EdgeInsets.all(10.0),
      child: Draggable<dynamic>(
        feedback: Material(
          elevation: 5.0,
          child: Container(
            width: 284.0,
            padding: const EdgeInsets.all(16.0),
            color: Colors.orange,
            child: Text('feedback'),
          ),
        ),
        childWhenDragging: Container(),
        data: {'kanbanCardDraggable': kanbanCard, 'newStage': newStage},
        child: Container(
          key: ValueKey(kanbanCard),
          // width: 200.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text('${kanbanCard.title} ${kanbanCard.stageCard}'),
                // subtitle: Text(
                //     'id:${kanbanCard.id.substring(0, 5)} | kanbanBoard:${kanbanCard.kanbanBoard?.substring(0, 5)} | description:${kanbanCard.description} | priority:${kanbanCard.priority} | active:${kanbanCard.active} | created:${kanbanCard.created} |  modified:${kanbanCard.modified} | team:${kanbanCard.team?.length} | '),
                onTap: () {
                  widget.onCurrentKanbanCardModel(kanbanCard.id);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => KanbanCardCRUD(),
                    ),
                  );
                },
              ),
              Center(
                child: Wrap(
                  children: avatarsTeam(kanbanCard.author, kanbanCard.team),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> avatarsTeam(Team author, Map<String, Team> teamMap) {
    List<Widget> listaWidget = List<Widget>();
    listaWidget.add(
      Tooltip(
        message: author.displayName,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red,
          child: CircleAvatar(
            radius: 19,
            child: ClipOval(
              child: Center(
                child: author?.photoUrl != null
                    ? Image.network(author.photoUrl)
                    : Icon(Icons.person_add),
              ),
            ),
          ),
        ),
      ),
    );

    List<Team> _team =
        teamMap != null ? teamMap.entries.map((e) => e.value).toList() : [];
    for (var item in _team) {
      listaWidget.add(
        InkWell(
          onTap: () {
            print('${item.id}');
          },
          child: Tooltip(
            message: item.displayName,
            child: Stack(
              children: [
                CircleAvatar(
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
                Icon(
                  Icons.remove_red_eye,
                  color: item?.readedCard ?? true
                      ? Colors.transparent
                      : Colors.red,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return listaWidget;
  }
}

/*


  List<Widget> listCard(List<KanbanCardModel> listKanbanCardModel) {
    List<Widget> listCards = [];

    listKanbanCardModel.forEach((kanbanCard) {
      listCards.add(Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text(kanbanCard.title),
              subtitle: Text(
                  'id:${kanbanCard.id.substring(0, 5)} | kanbanBoard:${kanbanCard.kanbanBoard?.substring(0, 5)} | description:${kanbanCard.description} | priority:${kanbanCard.priority} | active:${kanbanCard.active} | created:${kanbanCard.created} |  modified:${kanbanCard.modified} | team:${kanbanCard.team?.length} | '),
              onTap: () {
                widget.onCurrentKanbanCardModel(kanbanCard.id);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => KanbanCardCRUD(),
                  ),
                );
              },
            ),
            Center(
              child: Wrap(
                children: avatarsTeam(kanbanCard.author, kanbanCard.team),
              ),
            ),
          ],
        ),
      ));
    });

    return listCards;
  }

  List<Widget> avatarsTeam(Team author, Map<String, Team> teamMap) {
    List<Widget> listaWidget = List<Widget>();
    listaWidget.add(
      Tooltip(
        message: author.displayName,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red,
          child: CircleAvatar(
            radius: 19,
            child: ClipOval(
              child: Center(
                child: author?.photoUrl != null
                    ? Image.network(author.photoUrl)
                    : Icon(Icons.person_add),
              ),
            ),
          ),
        ),
      ),
    );

    List<Team> _team =
        teamMap != null ? teamMap.entries.map((e) => e.value).toList() : [];
    for (var item in _team) {
      listaWidget.add(
        InkWell(
          onTap: () {
            print('${item.id}');
          },
          child: Tooltip(
            message: item.displayName,
            child: Stack(
              children: [
                CircleAvatar(
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
                Icon(
                  Icons.remove_red_eye,
                  color: item?.readedCard ?? true
                      ? Colors.transparent
                      : Colors.red,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return listaWidget;
  }
  */
