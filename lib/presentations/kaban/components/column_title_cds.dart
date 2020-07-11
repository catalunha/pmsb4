import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/kanban_card_crud.dart';
import 'package:pmsb4/models/types_models.dart';

class ColumnTitleCDS extends StatelessWidget {
  final StageCard stageCard;

  const ColumnTitleCDS({Key key, this.stageCard}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            stageCard.name,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          stageCard.toString() == StageCard.todo.toString()
              ? IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => KanbanCardCRUD(
                        id: null,
                      ),
                    );
                  },
                )
              : Container()
          // onPressed: () {},
          // ),
        ],
      ),
    );
  }
}
