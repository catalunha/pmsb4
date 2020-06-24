import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/kanban_board_crud.dart';
import 'package:pmsb4/containers/kanban/kanban_filter.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/references_models.dart';
import 'package:pmsb4/states/enums.dart';

class KanbanBoardPageDS extends StatelessWidget {
  final List<KanbanBoardModel> filteredKanbanBoardModel;
  final Function(KanbanBoardFilter) kanbanBoardFilter;
  const KanbanBoardPageDS({
    Key key,
    this.filteredKanbanBoardModel,
    this.kanbanBoardFilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kanban Board Page'),
        actions: [KanbanFilter()],
      ),
      body: ListView.builder(
        itemCount: filteredKanbanBoardModel.length,
        itemBuilder: (BuildContext context, int index) {
          final kanbanBoard = filteredKanbanBoardModel[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(kanbanBoard.title),
                  subtitle: Text(
                      'id:${kanbanBoard.id.substring(0, 5)} | description:${kanbanBoard.description} | public:${kanbanBoard.public} | active:${kanbanBoard.active} | created:${kanbanBoard.created} |  modified:${kanbanBoard.modified} | team:${kanbanBoard.team?.length} | '),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KanbanBoardCRUD(
                          id: kanbanBoard.id,
                        ),
                      ),
                    );
                  },
                ),
                Center(
                  child: Wrap(
                    children: avatarsTeam(kanbanBoard.author, kanbanBoard.team),
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => KanbanBoardCRUD(
                id: null,
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> avatarsTeam(
      UserKabanRef author, Map<String, UserKabanRef> teamMap) {
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

    List<UserKabanRef> _team =
        teamMap != null ? teamMap.entries.map((e) => e.value).toList() : [];
    for (var item in _team) {
      listaWidget.add(
        InkWell(
          onTap: () {
            print('${item.id}');
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
}
