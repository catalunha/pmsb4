import 'package:flutter/material.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/presentations/kaban/components/short_card.dart';

class KanbanCardPageInactiveDS extends StatelessWidget {
  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;

  const KanbanCardPageInactiveDS(
      {Key key, this.filteredKanbanCardModel, this.onCurrentKanbanCardModel})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartões Arquivados'),
      ),
      body: ListView.builder(
          itemCount: filteredKanbanCardModel.length,
          itemBuilder: (BuildContext context, int index) {
            KanbanCardModel kanbanCardModel = filteredKanbanCardModel[index];
            return ShortCard(
              arquivado: true,
              cor: Colors.blue,
              tarefa: kanbanCardModel,
            );
          }),
    );
  }
}
