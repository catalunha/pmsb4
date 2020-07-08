import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/presentations/styles/pmsb_styles.dart';
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
      color: PmsbColors.navbar,
      icon: Icon(
        Icons.filter_list,
        color: Colors.white,
      ),
      onSelected: onSelectFilter,
      itemBuilder: (BuildContext context) => <PopupMenuItem<KanbanBoardFilter>>[
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.all,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.code,
                color: PmsbColors.texto_primario,
              ),
              SizedBox(width: 5),
              Text(
                KanbanBoardFilter.all.name,
                style: PmsbStyles.textoPrimario,
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.activeAuthor,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.person_pin_circle,
                color: PmsbColors.texto_primario,
              ),
              SizedBox(width: 5),
              Text(
                KanbanBoardFilter.activeAuthor.name,
                style: PmsbStyles.textoPrimario,
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.activeTeam,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.people,
                color: PmsbColors.texto_primario,
              ),
              SizedBox(width: 5),
              Text(
                KanbanBoardFilter.activeTeam.name,
                style: PmsbStyles.textoPrimario,
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.publics,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.public,
                color: PmsbColors.texto_primario,
              ),
              SizedBox(width: 5),
              Text(
                KanbanBoardFilter.publics.name,
                style: PmsbStyles.textoPrimario,
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanBoardFilter>(
          value: KanbanBoardFilter.inactive,
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(
                Icons.archive,
                color: PmsbColors.texto_primario,
              ),
              SizedBox(width: 5),
              Text(
                KanbanBoardFilter.inactive.name,
                style: PmsbStyles.textoPrimario,
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}
