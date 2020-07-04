import 'package:flutter/material.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class TeamCardFilteringDS extends StatelessWidget {
  final Team currentTeam;
  final List<Team> teamCard;

  final Function(Team) onSelectFilter;

  const TeamCardFilteringDS({
    Key key,
    this.currentTeam,
    this.teamCard,
    this.onSelectFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Team>(
        tooltip: "Filtrar por membro",
        color: PmsbColors.navbar,
        icon: Icon(
          Icons.supervised_user_circle,
          color: Colors.white,
        ),
        onSelected: onSelectFilter,
        itemBuilder: (BuildContext context) {
          // var list = List<PopupMenuEntry<Object>>();
          var list = List<PopupMenuItem<Team>>();
          list.add(PopupMenuItem<Team>(
            value: Team(id: null),
            child: ListTile(
              title: Text('Todos'),
              leading: Icon(
                Icons.people,
                color: Colors.black,
              ),
              trailing: currentTeam == Team()
                  ? Icon(Icons.check)
                  : Icon(
                      Icons.check,
                      color: Colors.transparent,
                    ),
            ),
          ));
          teamCard.forEach((element) {
            list.add(PopupMenuItem<Team>(
              value: element,
              child: ListTile(
                title: Text(element.displayName),
                leading: CircleAvatar(
                  radius: 19,
                  child: ClipOval(
                    child: Center(
                      child: element?.photoUrl != null
                          ? Image.network(element.photoUrl)
                          : Icon(Icons.person_add),
                    ),
                  ),
                ),
                trailing:
                    currentTeam?.id != null && currentTeam.id == element.id
                        ? Icon(Icons.check)
                        : Icon(
                            Icons.check,
                            color: Colors.transparent,
                          ),
              ),
            ));
          });
          return list;
          //   PopupMenuItem<KanbanCardFilter>(
          //     value: KanbanCardFilter.normal,
          //     child: activeFilter == KanbanCardFilter.normal
          //         ? Text('NORMAL')
          //         : Text('Normal'),
          //   ),
          //   PopupMenuItem<KanbanCardFilter>(
          //     value: KanbanCardFilter.priority,
          //     child: activeFilter == KanbanCardFilter.priority
          //         ? Text('PRIORIDADE')
          //         : Text('Prioridade'),
          //   ),
          // ],
        });
  }
}
