import 'package:flutter/material.dart';
import 'package:pmsb4/states/types_states.dart';

class KanbanBoardFilteringDS extends StatelessWidget {
  final Function(KanbanBoardFilter) onSelectFilter;
  final KanbanBoardFilter activeFilter;

  const KanbanBoardFilteringDS({
    Key key,
    this.onSelectFilter,
    this.activeFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<KanbanBoardFilter>(
      icon: Icon(Icons.filter_list),
      onSelected: onSelectFilter,
      itemBuilder: (BuildContext context) => <PopupMenuItem<KanbanBoardFilter>>[
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.all,
          child:
              activeFilter == KanbanBoardFilter.all ? Text('ALL') : Text('All'),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.active,
          child: activeFilter == KanbanBoardFilter.active
              ? Text('ACTIVE')
              : Text('Active'),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.inactive,
          child: activeFilter == KanbanBoardFilter.inactive
              ? Text('INACTIVE')
              : Text('inactive'),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.publics,
          child: activeFilter == KanbanBoardFilter.publics
              ? Text('PUBLICS')
              : Text('Publics'),
        ),
      ],
    );
  }
}
