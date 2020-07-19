import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/kanban_card_crud.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/column_title_cds.dart';
import 'package:pmsb4/presentations/kaban/components/short_card_cds.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class BoardViewKanbanDS extends StatelessWidget {
  final KanbanBoardModel currentKanbanBoardModel;
  final List<KanbanCardModel> filteredKanbanCardModel;
  final bool userLogedIsBoardAuthor;
  final Function(String) onCurrentKanbanCardModel;
  final Function(Map<String, String>) onChangeCardOrder;
  final Function(String, StageCard) onChangeStageCard;

  BoardViewKanbanDS({
    Key key,
    this.currentKanbanBoardModel,
    this.filteredKanbanCardModel,
    this.onCurrentKanbanCardModel,
    this.onChangeCardOrder,
    this.onChangeStageCard,
    this.userLogedIsBoardAuthor,
  }) : super(key: key);

  List<ColumnItems> columnItemsList = [];
  List<StageCards> stageCardsList = [];
  BoardViewController boardViewController = BoardViewController();

  @override
  Widget build(BuildContext context) {
    // print('BoardViewKanbanDS.build');
    columnItemsList = [];
    stageCardsList = [];
    buildColumnItemsList(context);

    List<BoardList> boardList = List<BoardList>();
    for (int i = 0; i < columnItemsList.length; i++) {
      boardList.add(_createBoardList(columnItemsList[i], context));
    }

    return BoardView(
      lists: boardList,
      boardViewController: boardViewController,
      width: 320,
    );
  }

  void buildColumnItemsList(BuildContext context) {
    for (var stageCard in StageCard.values) {
      List<Widget> shortCardCDSList = [];
      List<String> idCardList = [];
      for (var kanbanCard in filteredKanbanCardModel) {
        if (kanbanCard.stageCard == stageCard.toString()) {
          idCardList.add(kanbanCard.id);
          shortCardCDSList.add(
            ShortCardCDS(
              arquivado: false,
              onTap: userLogedIsBoardAuthor
                  ? () {
                      onCurrentKanbanCardModel(kanbanCard.id);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KanbanCardCRUD(
                            id: kanbanCard.id,
                          ),
                        ),
                      );
                    }
                  : null,
              tarefa: kanbanCard,
              cor: PmsbColors.card,
            ),
          );
        }
      }
      columnItemsList.add(
        ColumnItems(
            title: ColumnTitleCDS(
              stageCard: stageCard,
              userLogedIsBoardAuthor: userLogedIsBoardAuthor,
            ),
            items: shortCardCDSList),
      );
      stageCardsList.add(
        StageCards(stageCard: stageCard, idCards: idCardList),
      );
    }
    // for (var stageCards in stageCardsList) {
    //   print('*** ${stageCards.stageCard.name}');
    //   for (var cards in stageCards.idCards) {
    //     print('*** $cards');
    //   }
    // }
  }

  Widget _createBoardList(ColumnItems columnItems, BuildContext context) {
    List<BoardItem> boardItemList = List();
    for (var i = 0; i < columnItems.items.length; i++) {
      boardItemList.insert(i, buildBoardItem(columnItems.items[i]));
    }
    return BoardList(
      onStartDragList: (int listIndex) {
        // print('BoardList.onStartDragList={listIndex:$listIndex}');
      },
      onTapList: (int listIndex) {
        // print('BoardList.onTapList={listIndex:$listIndex}');
      },
      onDropList: (listIndex, oldListIndex) {
        // print(
        //     'BoardList.onDropList={listIndex:$listIndex,oldListIndex:$oldListIndex}');

        var boardListObject = columnItemsList[oldListIndex];
        columnItemsList.removeAt(oldListIndex);
        columnItemsList.insert(listIndex, boardListObject);
      },
      draggable: false,
      header: [columnItems.title],
      items: boardItemList,
    );
  }

  Widget buildBoardItem(Widget itemWidget) {
    return BoardItem(
      onStartDragItem: (int listIndex, int itemIndex, BoardItemState state) {
        // print(
        //     'BoardItem.onStartDragItem={listIndex:$listIndex,itemIndex:$itemIndex}');
      },
      onDropItem: (int listIndex, int itemIndex, int oldListIndex,
          int oldItemIndex, BoardItemState state) {
        // print(
        // 'BoardItem.onDropItem={listIndex:$listIndex,itemIndex:$itemIndex,oldListIndex:$oldListIndex,oldItemIndex:$oldItemIndex}');
        // print(
        // 'newStageCard:${StageCard.values[listIndex]},oldStageCard:${StageCard.values[oldListIndex]}');
        var item = columnItemsList[oldListIndex].items[oldItemIndex];
        columnItemsList[oldListIndex].items.removeAt(oldItemIndex);
        columnItemsList[listIndex].items.insert(itemIndex, item);

        var card = stageCardsList[oldListIndex].idCards[oldItemIndex];
        stageCardsList[oldListIndex].idCards.removeAt(oldItemIndex);
        stageCardsList[listIndex].idCards.insert(itemIndex, card);

        //+++ Atualiza ordem dos cards
        Map<String, String> cardOrder = Map<String, String>();
        cardOrder.clear();
        var index = 1;
        for (var stageCards in stageCardsList) {
          // print('+++ ${stageCards.stageCard.name}');
          for (var idCard in stageCards.idCards) {
            // print('+++ $idCard');
            cardOrder[(index++).toString()] = idCard;
          }
        }
        onChangeCardOrder(cardOrder);
        //---
        //+++ Se houve mudança de colunas entao atualiza o stageCard
        // if (listIndex != oldListIndex) {
        onChangeStageCard(card, StageCard.values[listIndex]);
        // }
        //---
        // buildColumnItemsList(context);
        // columnItemsList = [];
        // stageCardsList = [];
      },
      onTapItem: (int listIndex, int itemIndex, BoardItemState state) {
        // print(
        //     'BoardItem.onTapItem={listIndex:$listIndex,itemIndex:$itemIndex}');
      },
      onDragItem: (int oldListIndex, int oldItemIndex, int newListIndex,
          int newItemIndex, BoardItemState state) {},
      item: itemWidget,
    );
  }
}

class ColumnItems {
  Widget title;
  List<Widget> items;
  ColumnItems({this.title, this.items}) {
    if (this.title == null) {
      this.title = Container();
    }
    if (this.items == null) {
      this.items = [];
    }
  }
}

class StageCards {
  StageCard stageCard;
  List<String> idCards;
  StageCards({this.stageCard, this.idCards}) {
    if (this.stageCard == null) {
      this.stageCard = StageCard.todo;
    }
    if (this.idCards == null) {
      this.idCards = [];
    }
  }
}
