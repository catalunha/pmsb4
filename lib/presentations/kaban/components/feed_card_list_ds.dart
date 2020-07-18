import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_crud.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/kaban/components/feed_card_cds.dart';

class FeedCardListDS extends StatefulWidget {
  final List<Feed> listFeed;
  final Function(String) onDelete;
  final String loggedId;

  const FeedCardListDS({
    Key key,
    this.listFeed,
    this.loggedId,
    this.onDelete,
  }) : super(key: key);
  @override
  _FeedCardListDSState createState() => _FeedCardListDSState();
}

class _FeedCardListDSState extends State<FeedCardListDS> {
  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: getListaComentarios(),
    // );
    return Column(
      children: [
        ListTile(
          title: Text("Informações:"),
          leading: IconButton(
            tooltip: 'Acrescentar uma informação nova',
            icon: Icon(Icons.add_box),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => FeedCardCRUD(
                  id: null,
                ),
              );
            },
          ),
        ),
        Container(
          // width: 500,
          height: 400,
          child: ListView(
            children: getListaComentarios(),
          ),
        ),
      ],
    );
  }

  List<Widget> getListaComentarios() {
    List<Widget> listaComentarios = [];
    // listaComentarios.add(ListTile(
    //   title: Text("Informações:"),
    // ));
    for (Feed feed in widget.listFeed) {
      listaComentarios.add(FeedCardCDS(
        feed: feed,
        onDelete: widget.onDelete,
        loggedId: widget.loggedId,
      ));
      // listaComentarios.add(ListTile(
      //   title: Text(feed.description),
      // ));
    }
    return listaComentarios;
  }
}
