import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/states/types_states.dart';

class KanbanCardFilteringDS extends StatelessWidget with Components {
  final KanbanCardFilter activeFilter;
  final Function(KanbanCardFilter) onSelectFilter;

  KanbanCardFilteringDS({
    Key key,
    this.onSelectFilter,
    this.activeFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<KanbanCardFilter>(
      color: PmsbColors.fundo,
      icon: popupIcon(activeFilter),
      tooltip: "Filtrar por prioridade",
      onSelected: onSelectFilter,
      itemBuilder: (BuildContext context) => <PopupMenuItem<KanbanCardFilter>>[
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.priority,
          child: Row(
            children: [
              SizedBox(width: 2),
              priorityIcon,
              SizedBox(width: 5),
              Text(KanbanCardFilter.priority.name),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.all,
          child: Row(
            children: [
              SizedBox(width: 2),
              allIcon,
              SizedBox(width: 5),
              Text(KanbanCardFilter.all.name),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<KanbanCardFilter>(
          value: KanbanCardFilter.normal,
          child: Row(
            children: [
              SizedBox(width: 2),
              normalIcon,
              SizedBox(width: 5),
              Text(KanbanCardFilter.normal.name),
              SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}

class Components {
  final priorityIcon = Icon(
    Icons.brightness_1,
    color: Colors.grey[900],
  );
  final allIcon = Icon(
    Icons.brightness_3,
    // color: Colors.transparent,
  );
  final normalIcon = Icon(
    Icons.brightness_1,
    color: PmsbColors.card,
  );

  Icon popupIcon(KanbanCardFilter currentKanbanCardFilter) {
    var icon = allIcon;
    if (currentKanbanCardFilter == KanbanCardFilter.priority) {
      icon = priorityIcon;
    } else if (currentKanbanCardFilter == KanbanCardFilter.normal) {
      icon = normalIcon;
    }
    return icon;
  }
}
