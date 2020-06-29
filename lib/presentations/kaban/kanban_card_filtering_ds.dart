import 'package:flutter/material.dart';
import 'package:pmsb4/states/type_states.dart';

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
      icon: Icon(Icons.filter_list),
      onSelected: onSelectFilter,
      itemBuilder: (BuildContext context) => <PopupMenuItem<KanbanCardFilter>>[
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.all,
          child:
              activeFilter == KanbanCardFilter.all ? Text('ALL') : Text('All'),
        ),
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.normal,
          child: activeFilter == KanbanCardFilter.normal
              ? Text('NORMAL')
              : Text('Normal'),
        ),
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.priority,
          child: activeFilter == KanbanCardFilter.priority
              ? Text('PRIORIDADE')
              : Text('Prioridade'),
        ),
      ],
    );
  }
}
