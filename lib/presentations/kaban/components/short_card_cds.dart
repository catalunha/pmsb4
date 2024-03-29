import 'package:flutter/material.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:intl/intl.dart';
import 'package:pmsb4/presentations/styles/pmsb_styles.dart';

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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: tarefa.priority ? Colors.grey[900] : PmsbColors.card,
          border: Border(),
        ),
        height: this.altura,
        width: this.largura,
        child: Column(
          children: [
            ListTile(
              title: Text("${tarefa.title}"),
              subtitle: Tooltip(
                message:
                    'Descrição: ${tarefa.description}.\nId: ${tarefa.id.substring(0, 5)}.',
                child:
                    // ${DateFormat('dd-MM HH').format(tarefa.modified)}h.
                    Text(
                        "#${tarefa.number}. ${(DateTime.now().difference(tarefa.created)).inDays} ${(DateTime.now().difference(tarefa.created)).inDays == 1 ? "dia" : "dias"}. ${DateFormat('dd-MM HH:MM').format(tarefa.modified)}. Ações: ${tarefa.todoCompleted}/${tarefa.todoTotal}."),
              ),
              onTap: onTap,
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: gerarListaUsuarios(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> gerarListaUsuarios() {
    List<Widget> listaEtiqueta = List<Widget>();
    if (tarefa.team?.entries != null) {
      List<Team> teamList = [];
      teamList = tarefa.team.entries.map((e) => e.value).toList()
        ..sort((a, b) => a.displayName.compareTo(b.displayName));
      for (var user in teamList) {
        listaEtiqueta.add(userCard(user));
      }
    }
    return listaEtiqueta;
  }

  Widget userCard(Team user) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Tooltip(
          message: '${user.displayName}',
          child: Container(
            padding: EdgeInsets.all(3),
            height: 30,
            width: 30,
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: ClipOval(
                  child: user.photoUrl == null
                      ? Text(
                          user.displayName[0].toUpperCase() +
                              user.displayName[1].toUpperCase(),
                          style: PmsbStyles.textoSecundario,
                        )
                      : Image.network(user.photoUrl),
                )),
          ),
        ),
        user?.readedCard != null && !user.readedCard
            ? Positioned(
                top: 20,
                left: 20,
                child:
                    Icon(Icons.brightness_1, color: Colors.redAccent, size: 10),
              )
            : Text(''),
      ],
    );
  }
}
