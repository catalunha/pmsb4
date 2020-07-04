import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_crud.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/feed_card_one.dart';

class FeedCardListDS extends StatefulWidget {
  final List<Feed> listFeed;
  final Function(String) onDelete;

  const FeedCardListDS({
    Key key,
    this.listFeed,
    this.onDelete,
  }) : super(key: key);
  @override
  _FeedCardListDSState createState() => _FeedCardListDSState();
}

class _FeedCardListDSState extends State<FeedCardListDS> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FeedCardCRUD(),
          ),
          _listaComentario()
        ],
      ),
    );
  }

  Widget _listaComentario() {
    return Container(
      child: Column(children: getListaComentarios()),
    );
  }

  List<Widget> getListaComentarios() {
    List<Widget> listaComentarios = List<Widget>();
    for (Feed feed in widget.listFeed) {
      listaComentarios.add(FeedCardOne(feed: feed));
    }
    return listaComentarios;
  }
}
