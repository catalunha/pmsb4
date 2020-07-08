import 'package:flutter/material.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/states/types_states.dart';

class ShortBoardCDS extends StatelessWidget {
  final Color cor;
  final double altura;
  final double largura;
  final KanbanBoardModel quadro;
  final Function onViewKanbanCards;
  final Function onEditCurrentKanbanBoardModel;
  final Function(String, bool) onActive;
  final KanbanBoardFilter kanbanBoardFilter;

  ShortBoardCDS(
      {Key key,
      @required this.cor,
      this.altura,
      this.largura,
      this.quadro,
      this.onViewKanbanCards,
      this.onEditCurrentKanbanBoardModel,
      this.onActive,
      this.kanbanBoardFilter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: this.cor,
      height: this.altura,
      width: this.largura,
      child: Column(
        children: [
          Row(
            children: [
              // SizedBox(width: 5),
              // CircleAvatar(
              //   radius: 19,
              //   child: ClipOval(
              //     child: Center(
              //       child: quadro.author?.photoUrl != null
              //           ? Image.network(quadro.author.photoUrl)
              //           : Icon(Icons.person_add),
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 19,
                    child: ClipOval(
                      child: Center(
                        child: quadro.author?.photoUrl != null
                            ? Image.network(quadro.author.photoUrl)
                            : Icon(Icons.person_add),
                      ),
                    ),
                  ),
                  onTap: this.onViewKanbanCards,
                  trailing:
                      Icon(this.quadro.public ? Icons.lock_open : Icons.lock),
                  title: Text("${this.quadro.title}"),
                  subtitle: Text(
                      "Tarefas em andamento: ${quadro.cardOrder?.length ?? 0}\nDescrição: ${this.quadro.description}"),
                ),
              ),
              kanbanBoardFilter.toString() ==
                          KanbanBoardFilter.activeAuthor.toString() ||
                      kanbanBoardFilter.toString() ==
                          KanbanBoardFilter.inactive.toString()
                  ? botaoMore()
                  : Container(),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: gerarListaUsuarios(),
            ),
          ),
        ],
      ),
    );
  }

  Widget botaoMore() {
    return PopupMenuButton<Function>(
      tooltip: "Mostrar Menu",
      color: PmsbColors.fundo,
      onSelected: (Function result) {
        result();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
        kanbanBoardFilter.toString() ==
                KanbanBoardFilter.activeAuthor.toString()
            ? PopupMenuItem<Function>(
                value: () {
                  onEditCurrentKanbanBoardModel();
                },
                child: Row(
                  children: [
                    SizedBox(width: 2),
                    Icon(Icons.edit),
                    SizedBox(width: 5),
                    Text('Editar'),
                    SizedBox(width: 5),
                  ],
                ),
              )
            : null,
        kanbanBoardFilter.toString() ==
                    KanbanBoardFilter.activeAuthor.toString() ||
                kanbanBoardFilter.toString() ==
                    KanbanBoardFilter.inactive.toString()
            ? PopupMenuItem<Function>(
                value: () {
                  onActive(quadro.id, !quadro.active);
                },
                child: Row(
                  children: [
                    SizedBox(width: 2),
                    Icon(Icons.move_to_inbox),
                    SizedBox(width: 5),
                    kanbanBoardFilter.toString() ==
                            KanbanBoardFilter.activeAuthor.toString()
                        ? Text('Arquivar')
                        : Text('Reativar'),
                    SizedBox(width: 5),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  List<Widget> gerarListaUsuarios() {
    List<Widget> usuariosWidget = List<Widget>();
    if (this.quadro?.team != null) {
      for (var usuario in this.quadro.team.entries) {
        usuariosWidget.add(Padding(
          padding: const EdgeInsets.only(
            left: 15,
            bottom: 5,
          ),
          child: Tooltip(
            message: usuario.value.displayName,
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue[50],
              // child: Text(usuario.value.displayName[0].toUpperCase() +
              //     usuario.value.displayName[1].toUpperCase()),
              backgroundImage: usuario.value.photoUrl != null
                  ? NetworkImage(usuario.value.photoUrl)
                  : NetworkImage(''),
            ),
          ),
        ));
      }
    }
    return usuariosWidget;
  }
}
