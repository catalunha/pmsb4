import 'package:flutter/material.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:intl/intl.dart';

class ShortCardCDS extends StatelessWidget {
  final Color cor;
  final double altura;
  final double largura;
  final KanbanCardModel tarefa;
  final bool arquivado;
  final Function() onTap;
  final Function(String) onActiveTrueCard;

  ShortCardCDS({
    Key key,
    @required this.cor,
    @required this.arquivado,
    this.altura,
    this.largura,
    this.tarefa,
    this.onTap,
    this.onActiveTrueCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tarefa.priority ? PmsbColors.cor_destaque : PmsbColors.card,
        border: Border(),
      ),
      height: this.altura,
      width: this.largura,
      child: Column(
        children: [
          Tooltip(
            message:
                'Data e hora da última atualização e quantidade de ações atendidas. Identificador: ${tarefa.id.substring(0, 4)}. ',
            child: ListTile(
              title: Text("${tarefa.title}"),
              subtitle: Text(
                  "A: ${DateFormat('dd-MM HH').format(tarefa.modified)}h. D: ${(DateTime.now().difference(tarefa.created)).inDays}d. Ações: ${tarefa.todoCompleted}-${tarefa.todoTotal}"),
              onTap: onTap,
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            children: gerarListaUsuarios(),
          ),
        ],
      ),
    );
  }

  List<Widget> gerarListaUsuarios() {
    List<Widget> listaEtiqueta = List<Widget>();
    if (tarefa.team?.entries != null) {
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
              // child: Text(user.displayName[0].toUpperCase() +
              //     user.displayName[1].toUpperCase()),
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
