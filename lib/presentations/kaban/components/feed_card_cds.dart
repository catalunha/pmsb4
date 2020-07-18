import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_crud.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:url_launcher/url_launcher.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class FeedCardCDS extends StatefulWidget {
  final Feed feed;
  final Function(String) onDelete;
  final String loggedId;

  FeedCardCDS({
    Key key,
    this.feed,
    this.loggedId,
    this.onDelete,
  }) : super(key: key);

  @override
  _FeedCardCDSState createState() => _FeedCardCDSState();
}

class _FeedCardCDSState extends State<FeedCardCDS> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      child: Card(
        color: PmsbColors.card,
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: ListTile(
                onTap: null,
                onLongPress: null,
                leading: Tooltip(
                  message: widget.feed.author?.displayName ?? '',
                  child: ClipOval(
                    child: CircleAvatar(
                      backgroundColor: Colors.lightBlue[50],
                      child: widget.feed.author?.photoUrl != null
                          ? Image.network(widget.feed.author.photoUrl)
                          : Text(widget.feed.author?.displayName ??
                              ''.substring(0, 2).toUpperCase()),
                    ),
                  ),
                ),
                title: Text(widget.feed.description),
                subtitle: Text(widget.feed.created.toString()),
                trailing: widget.feed.link != null
                    ? IconButton(
                        icon: Icon(Icons.link),
                        tooltip: widget.feed.link,
                        onPressed: () async {
                          if (widget.feed?.link != null) {
                            if (await canLaunch(widget.feed.link)) {
                              await launch(widget.feed.link);
                            }
                          }
                        },
                      )
                    : Container(
                        width: 1,
                      ),
              ),
            ),
            Expanded(
              flex: 1,
              child: (widget.loggedId == widget.feed.author.id) &&
                      (!widget.feed.bot)
                  ? botaoMore(id: widget.feed.id)
                  : Container(),
            )
          ],
        ),
      ),
    );
  }

  Widget botaoMore({String id}) {
    return PopupMenuButton<Function>(
      color: PmsbColors.fundo,
      onSelected: (Function result) {
        result();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Function>>[
        PopupMenuItem<Function>(
          value: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => FeedCardCRUD(
                id: id,
              ),
            );
          },
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(Icons.edit),
              SizedBox(width: 5),
              Text('Editar'),
              SizedBox(width: 5),
            ],
          ),
        ),
        PopupMenuItem<Function>(
          value: () {
            widget.onDelete(id);
          },
          child: Row(
            children: [
              SizedBox(width: 2),
              Icon(Icons.delete),
              SizedBox(width: 5),
              Text('Apagar'),
              SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}
