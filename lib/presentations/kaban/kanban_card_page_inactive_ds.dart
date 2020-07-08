import 'package:flutter/material.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/presentations/kaban/components/short_card_cds.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/routes.dart';

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
      backgroundColor: PmsbColors.fundo,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PmsbColors.fundo,
        centerTitle: true,
        title: Text('Cartões Arquivados'),
        //automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Routes.kanbanCardPage);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            /*Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.8,
              color: PmsbColors.card,
            ),*/
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
