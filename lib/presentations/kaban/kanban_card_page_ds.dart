import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/kanban_card_crud.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/references_models.dart';

class KanbanCardPageDS extends StatelessWidget {
  final List<KanbanCardModel> filteredKanbanCardModel;
  const KanbanCardPageDS({
    Key key,
    this.filteredKanbanCardModel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kanban Card Page ${filteredKanbanCardModel.length}'),
        // actions: [KanbanFilter()],
      ),
      body: ListView.builder(
        itemCount: filteredKanbanCardModel.length,
        itemBuilder: (BuildContext context, int index) {
          final kanbanCard = filteredKanbanCardModel[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(kanbanCard.title),
                      //  
                  subtitle: Text(
                      'id:${kanbanCard.id.substring(0, 5)} | kanbanBoard:${kanbanCard.kanbanBoard?.substring(0, 5)} | description:${kanbanCard.description} | priority:${kanbanCard.priority} | active:${kanbanCard.active} | created:${kanbanCard.created} |  modified:${kanbanCard.modified} | team:${kanbanCard.team?.length} | '),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KanbanCardCRUD(
                          id: kanbanCard.id,
                        ),
                      ),
                    );
                  },
                ),
                Center(
                  child: Wrap(
                    children: avatarsTeam(kanbanCard.author, kanbanCard.team),
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
              builder: (context) => KanbanCardCRUD(
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
