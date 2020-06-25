import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/feed_card_crud.dart';
import 'package:pmsb4/models/kaban_card_model.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedCardPageDS extends StatelessWidget {
  final List<Feed> listFeed;
  final Function(String) onDelete;

  const FeedCardPageDS({
    Key key,
    this.listFeed,
    this.onDelete,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FeedCardPage'),
      ),
      body: ListView.builder(
        itemCount: listFeed.length,
        itemBuilder: (BuildContext context, int index) {
          final feed = listFeed[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  leading: InkWell(
                    onTap: () async {
                      if (feed?.link != null && feed.link.isNotEmpty) {
                        if (await canLaunch(feed.link)) {
                          await launch(feed.link);
                        } else {
                          // throw 'Could not launch $feed.link';
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          minRadius: 20,
                          maxRadius: 20,
                          child: ClipOval(
                            child: Center(
                              child: feed.author?.photoUrl != null
                                  ? Image.network(feed.author.photoUrl)
                                  : Icon(Icons.person_add),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.link,
                          color: (feed?.link != null && feed.link.isNotEmpty)
                              ? Colors.red
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  title: Text('description: ${feed.description}'),
                  subtitle: Text(
                      'link: ${feed.link}| author: ${feed.author.displayName} | author.id: ${feed.author.id.substring(0, 5)} | idFeed: ${feed.id.substring(0, 5)} | created: ${feed.created}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      onDelete(feed.id);
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FeedCardCRUD(
                          id: feed.id,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FeedCardCRUD(
                  id: null,
                ),
              ),
            );
          }),
    );
  }
}
