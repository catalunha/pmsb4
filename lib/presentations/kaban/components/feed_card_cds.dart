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
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: 5),
      child: Card(
        color: PmsbColors.card,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Chip(
                    backgroundColor: PmsbColors.card,
                    label: Text(widget.feed.author.displayName),
                    avatar: CircleAvatar(
                      backgroundColor: Colors.lightBlue[50],
                      // child: Text(
                      //     widget.feed.author.displayName[0].toUpperCase() +
                      //         widget.feed.author.displayName[1].toUpperCase()),
                      backgroundImage: widget.feed.author.photoUrl != null
                          ? NetworkImage(widget.feed.author.photoUrl)
                          : NetworkImage(''),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${widget.feed.created}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    (widget.loggedId == widget.feed.author.id) &&
                            (!widget.feed.bot)
                        ? botaoMore(id: widget.feed.id)
                        : Container(),
                  ],
                )
              ],
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: _selecionarTipoFeed(),
            ),
            SizedBox(height: 10),
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

  Widget _selecionarTipoFeed() {
    Widget widgetSelect;
    if (widget.feed.bot) {
      widgetSelect = _feedTipoHistorico();
    } else if (widget.feed?.link != null) {
      widgetSelect = _feedTipoLink();
    } else {
      widgetSelect = _feedTipoTexto();
    }

    return widgetSelect;
  }

  Widget _feedTipoLink() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: InkWell(
          hoverColor: Colors.white12,
          onTap: () async {
            if (widget.feed?.link != null) {
              if (await canLaunch(widget.feed.link)) {
                await launch(widget.feed.link);
              } else {
                // throw 'Could not launch $feed.link';
              }
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 10),
              Icon(Icons.link),
              SizedBox(width: 20),
              Text(
                "${widget.feed.description}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue[100],
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feedTipoTexto() {
    return Container(
      child: Text(widget.feed.description),
    );
  }

  Widget _feedTipoHistorico() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.feed.description,
              style:
                  TextStyle(color: PmsbColors.texto_secundario, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
