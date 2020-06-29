import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/models/type_models.dart';

class TeamCardDS extends StatefulWidget {
  final List<Team> teamBoard;
  final List<Team> teamCard;
  final Function(String) addUserTeam;
  TeamCardDS({
    Key key,
    this.teamBoard,
    this.teamCard,
    this.addUserTeam,
  }) : super(key: key);

  @override
  _TeamCardDSState createState() => _TeamCardDSState();
}

class _TeamCardDSState extends State<TeamCardDS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time para este card'),
      ),
      body: ListView.builder(
        itemCount: widget.teamBoard.length,
        itemBuilder: (BuildContext context, int index) {
          final _teamBoard = widget.teamBoard[index];
          return ListTile(
            title: Text(_teamBoard.displayName),
            leading: CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              child: ClipOval(
                child: Center(
                  child: _teamBoard?.photoUrl != null
                      ? Image.network(_teamBoard.photoUrl)
                      : Icon(Icons.chat),
                ),
              ),
            ),
            trailing: Checkbox(
                value: widget.teamCard
                        .indexWhere((element) => element.id == _teamBoard.id) >=
                    0,
                activeColor: Colors.green,
                onChanged: (value) {
                  widget.addUserTeam(_teamBoard.id);
                  setState(() {});
                }),
          );
        },
      ),
    );
  }
}
