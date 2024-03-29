import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/team_card.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class TeamCardAddCDS extends StatefulWidget {
  final List<Team> team;
  final Function(String) onRemoveUserTeam;

  const TeamCardAddCDS({Key key, this.team, this.onRemoveUserTeam})
      : super(key: key);

  @override
  _TeamCardAddCDSState createState() => _TeamCardAddCDSState();
}

class _TeamCardAddCDSState extends State<TeamCardAddCDS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textoQuadro("Equipe"),
              SizedBox(width: 5),
              IconButton(
                  icon: Icon(
                    Icons.person_add,
                    size: 20,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => TeamCard());
                  })
            ],
          ),
          Container(
            //color: Colors.red,
            // width: MediaQuery.of(context).size.width * 0.77,
            child: Wrap(
                direction: Axis.horizontal,
                textDirection: TextDirection.ltr,
                spacing: 8.0,
                runSpacing: 4.0,
                children: gerarListaUsuarios()),
          ),
        ],
      ),
    );
  }

  Widget textoQuadro(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 5),
      child: Text(
        texto,
        style: TextStyle(
          color: PmsbColors.texto_secundario,
          fontSize: 14,
        ),
      ),
    );
  }

  List<Widget> gerarListaUsuarios() {
    List<Widget> usuariosWidget = List<Widget>();
    for (var usuario in this.widget.team) {
      usuariosWidget.add(Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            // //print('removendo user${item.id}');
            widget.onRemoveUserTeam(usuario.id);
          },
          child: Tooltip(
            message: usuario.displayName,
            child: ClipOval(
              child: CircleAvatar(
                backgroundColor: Colors.lightBlue[50],
                // child: Text(usuario.displayName[0].toUpperCase() +
                //     usuario.displayName[1].toUpperCase()),
                child: usuario.photoUrl != null
                    ? Image.network(usuario.photoUrl)
                    : Text(usuario.displayName.substring(0, 2).toUpperCase()),
              ),
            ),
          ),
        ),
      ));
    }
    return usuariosWidget;
  }
}
