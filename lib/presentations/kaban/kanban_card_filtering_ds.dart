import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/states/types_states.dart';

class KanbanCardFilteringDS extends StatelessWidget {
  final KanbanCardFilter activeFilter;
  final Function(KanbanCardFilter) onSelectFilter;

  const KanbanCardFilteringDS({
    Key key,
    this.onSelectFilter,
    this.activeFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<KanbanCardFilter>(
      color: PmsbColors.navbar,
      icon: Icon(
        Icons.group_work,
        color: Colors.white,
      ),
      tooltip: "Filtrar por prioridade",
      onSelected: onSelectFilter,
      itemBuilder: (BuildContext context) => <PopupMenuItem<KanbanCardFilter>>[
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.priority,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.brightness_1,
                color: Colors.red,
              ),
              SizedBox(width: 5),
              Text(KanbanCardFilter.priority.name),
              SizedBox(width: 5),
            ],
          ),
          // child: activeFilter == KanbanCardFilter.priority
          //     ? Text('PRIORIDADE')
          //     : Text('Prioridade'),
        ),
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.all,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.brightness_1,
                color: Colors.transparent,
              ),
              SizedBox(width: 5),
              Text(KanbanCardFilter.all.name),
              SizedBox(width: 5),
            ],
          ),
          // child:
          //     activeFilter == KanbanCardFilter.all ? Text('ALL') : Text('All'),
        ),
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.normal,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.brightness_1,
                color: Colors.green,
              ),
              SizedBox(width: 5),
              Text(KanbanCardFilter.normal.name),
              SizedBox(width: 5),
            ],
          ),
          // child: activeFilter == KanbanCardFilter.normal
          //     ? Text('NORMAL')
          //     : Text('Normal'),
        ),
      ],
    );
  }
}
