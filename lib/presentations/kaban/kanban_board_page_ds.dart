import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/kanban_board_crud.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/states/enums.dart';

class KanbanBoardPageDS extends StatelessWidget {
  final List<KanbanBoardModel> listKanbanBoardModel;
  final Function(KanbanBoardFilter) kanbanBoardFilter;
  const KanbanBoardPageDS({
    Key key,
    this.listKanbanBoardModel,
    this.kanbanBoardFilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kanban Board List'),
      ),
      body: ListView.builder(
        itemCount: listKanbanBoardModel.length,
        itemBuilder: (BuildContext context, int index) {
          final kanbanBoard = listKanbanBoardModel[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(kanbanBoard.title),
                  subtitle: Text(
                      'id:${kanbanBoard.id} |description:${kanbanBoard.description} |public:${kanbanBoard.public} | active:${kanbanBoard.active} | created:${kanbanBoard.created} |  modified:${kanbanBoard.modified} | '),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => KanbanBoardCRUD(
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
                Center(
                  child: Wrap(
                    children: [
                      CircleAvatar(
                        minRadius: 20,
                        maxRadius: 20,
                        // backgroundImage: NetworkImage(photoUrl),
                        child: ClipOval(
                          child: Center(
                            child: kanbanBoard?.author?.photoUrl != null
                                ? Image.network(kanbanBoard.author.photoUrl)
                                : Icon(Icons.chat),
                          ),
                        ),
                      ),
                      
                    ],
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
                index: null,
              ),
            ),
          );
        },
      ),
    );
  }
}

