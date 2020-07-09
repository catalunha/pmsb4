import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/kanban_card_page.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/presentations/kaban/components/short_card_cds.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class KanbanCardPageInactiveDS extends StatelessWidget {
  final List<KanbanCardModel> filteredKanbanCardModel;
  final Function(String) onCurrentKanbanCardModel;
  final Function(String) onActiveTrueCard;

  const KanbanCardPageInactiveDS({
    Key key,
    this.filteredKanbanCardModel,
    this.onCurrentKanbanCardModel,
    this.onActiveTrueCard,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PmsbColors.navbar,
      appBar: AppBar(
        title: Text('Cartões Arquivados'),
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.assignment_return),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pushNamed(context, Routes.kanbanCardPage);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KanbanCardPage(),
                ),
              );
            }),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.grey,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.3),
                child: ListView.builder(
                  itemCount: filteredKanbanCardModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    KanbanCardModel kanbanCardModel =
                        filteredKanbanCardModel[index];
                    return ShortCardCDS(
                      arquivado: true,
                      cor: Colors.blue,
                      tarefa: kanbanCardModel,
                      onTap: () {
                        onActiveTrueCard(kanbanCardModel.id);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
