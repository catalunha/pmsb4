import 'package:flutter/material.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class TarefaCardWidget extends StatelessWidget {
  final Color cor;
  final double altura;
  final double largura;
  final KanbanCardModel tarefa;
  final bool arquivado;
  final Function() onTap;

  TarefaCardWidget(
      {Key key,
      @required this.cor,
      @required this.arquivado,
      this.altura,
      this.largura,
      this.tarefa,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: PmsbColors.card,
        border: Border(),
      ),
      height: this.altura,
      width: this.largura,
      child: Column(
        children: [
          arquivado
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "PENDENTE",
                        style: TextStyle(color: Colors.grey[400], fontSize: 12),
                      ),
                    ),
                  ],
                )
              : Container(),
          ListTile(
            title: Text("${this.tarefa.title}"),
            subtitle: Text(
                "${tarefa.modified} - Ações:${tarefa.todoCompleted}/${tarefa.todoTotal}"),
            onTap: onTap,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: gerarListaUsuarios(),
              ),
              Tooltip(
                message: "Prioridade alta",
                child: Icon(Icons.brightness_1, color: Colors.redAccent),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> gerarListaUsuarios() {
    List<Widget> listaEtiqueta = List<Widget>();
    if (tarefa.team?.entries != null && tarefa.team.entries.isNotEmpty) {
      for (var user in tarefa.team?.entries) {
        listaEtiqueta.add(userCard(user.value));
      }
    }
    return listaEtiqueta;
  }

  Widget userCard(Team user) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Tooltip(
          message: user.displayName,
          child: Container(
            padding: EdgeInsets.all(1),
            height: 30,
            width: 30,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Text(user.displayName[0].toUpperCase() +
                  user.displayName[1].toUpperCase()),
              backgroundImage: user.photoUrl != null
                  ? NetworkImage(user.photoUrl)
                  : NetworkImage(''),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 20,
          child: Icon(Icons.brightness_1, color: Colors.redAccent, size: 10),
        )
      ],
    );
  }
}
