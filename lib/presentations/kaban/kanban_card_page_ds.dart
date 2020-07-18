import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/board_view_kanban.dart';
import 'package:pmsb4/containers/kanban/kanban_board_page.dart';
import 'package:pmsb4/containers/kanban/kanban_card_filtering.dart';
import 'package:pmsb4/containers/kanban/kanban_card_page_inactive.dart';
import 'package:pmsb4/containers/kanban/team_card_filtering.dart';
import 'package:pmsb4/models/kaban_board_model.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class KanbanCardPageDS extends StatelessWidget {
  final KanbanBoardModel currentKanbanBoardModel;

  KanbanCardPageDS({
    Key key,
    this.currentKanbanBoardModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('KanbanCardPageDS.build');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: PmsbColors.fundo,
        title: Text("${currentKanbanBoardModel?.title}"),
      ),
      backgroundColor: PmsbColors.fundo,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: width > 1800 ? 15 : 3),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width > 1800 ? (width * 0.10) : (width * 0.01),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  currentKanbanBoardModel?.description,
                  style: TextStyle(
                      fontSize: 18, color: PmsbColors.texto_terciario),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: CircleAvatar(
                        backgroundColor: PmsbColors.navbar,
                        child: TeamCardFiltering(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: CircleAvatar(
                        backgroundColor: PmsbColors.navbar,
                        child: KanbanCardFiltering(),
                      ),
                    ),
                    InkWell(
                      child: Tooltip(
                        message: "Ver cartões arquivados",
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("userAvatarUrl"),
                          backgroundColor: PmsbColors.navbar,
                          child: Icon(
                            Icons.archive,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        // Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KanbanCardPageInactive(),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width > 1800 ? (width * 0.5) : (width * 0.01),
            ),
            child: Container(
              color: Colors.white12,
              height: 2,
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: SizedBox(width: 1280, child: BoardViewKanban()),
          ),
        ],
      ),
    );
  }
}
