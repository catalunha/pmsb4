import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
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
      tooltip: "Opções para quadros",
      color: PmsbColors.fundo,
      icon: Icon(Icons.filter_list),
      onSelected: onSelectFilter,
      itemBuilder: (BuildContext context) => <PopupMenuItem<KanbanBoardFilter>>[
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.all,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(Icons.archive),
              SizedBox(width: 5),
              Text('TODOS OS QUADRO (DEV)'),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.activeAuthor,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(Icons.archive),
              SizedBox(width: 5),
              Text('Quadros que coordeno'),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.activeTeam,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(Icons.archive),
              SizedBox(width: 5),
              Text('Quadros que faço parte'),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.publics,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(Icons.archive),
              SizedBox(width: 5),
              Text('Quadros públicos'),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.inactive,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(Icons.archive),
              SizedBox(width: 5),
              Text('Meus quadro arquivados'),
              SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}
