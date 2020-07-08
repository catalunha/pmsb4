import 'package:flutter/material.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/presentations/styles/pmsb_styles.dart';
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
      //height: this.altura,
      width: this.largura,
      child: Column(
        children: [
          ListTile(
            onTap: this.onViewKanbanCards,
            trailing: Icon(this.quadro.public ? Icons.lock_open : Icons.lock),
            title: Text("${this.quadro.title}"),
            subtitle: Text(
                "Tarefas em andamento: ${quadro.cardOrder?.length ?? 0}\nDescrição: ${this.quadro.description}"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  //Imagem do criado do quadro com marca
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: quadro.author?.displayName,
                        child: CircleAvatar(
                          backgroundColor: PmsbColors.navbar,
                          child: quadro.author?.photoUrl == null
                              ? Text(
                                  quadro.author?.displayName[0].toUpperCase() +
                                      quadro.author?.displayName[1]
                                          .toUpperCase(),
                                  style: PmsbStyles.textoSecundario,
                                )
                              : Image.network(quadro.author?.photoUrl),
                          // backgroundImage: quadro.author?.photoUrl != null
                          //     ? NetworkImage(quadro.author?.photoUrl)
                          //     : NetworkImage(""),
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        color: PmsbColors.cor_destaque,
                        width: 30,
                        height: 4,
                      ),
                    ],
                  ),
                  // Lista de usuarios
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      children: gerarListaUsuarios(),
                    ),
                  ),
                ],
              ),
              //Botão de opcoes
              kanbanBoardFilter.toString() ==
                          KanbanBoardFilter.activeAuthor.toString() ||
                      kanbanBoardFilter.toString() ==
                          KanbanBoardFilter.inactive.toString()
                  ? botaoMore()
                  : Container()
            ],
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
            child: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: CircleAvatar(
                backgroundColor: PmsbColors.navbar,
                child: usuario.value.photoUrl == null
                    ? Text(
                        usuario.value.displayName[0].toUpperCase() +
                            usuario.value.displayName[1].toUpperCase(),
                        style: PmsbStyles.textoSecundario,
                      )
                    : Container(),
                backgroundImage: usuario.value.photoUrl != null
                    ? NetworkImage(usuario.value.photoUrl)
                    : NetworkImage(''),
              ),
            ),
          ),
        ));
      }
    }
    return usuariosWidget;
  }
}
