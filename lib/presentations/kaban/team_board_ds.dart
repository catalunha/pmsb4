import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/models/user_model.dart';

class TeamBoardDS extends StatefulWidget {
  final List<UserModel> filteredUserModel;
  // final List<UserModel> selectedUserModel;
  final List<Team> team;
  final Function(String) addUserTeam;
  TeamBoardDS({
    Key key,
    this.filteredUserModel,
    // this.selectedUserModel,
    this.team,
    this.addUserTeam,
  }) : super(key: key);

  @override
  _TeamBoardDSState createState() => _TeamBoardDSState();
}

class _TeamBoardDSState extends State<TeamBoardDS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time para este quadro'),
      ),
      body: ListView.builder(
        itemCount: widget.filteredUserModel.length,
        itemBuilder: (BuildContext context, int index) {
          final userModel = widget.filteredUserModel[index];
          return ListTile(
            title: Text(userModel.displayName),
            subtitle: Text(userModel.id),
            leading: CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              child: ClipOval(
                child: Center(
                  child: userModel?.photoUrl != null
                      ? Image.network(userModel.photoUrl)
                      : Icon(Icons.chat),
                ),
              ),
            ),
            trailing: Checkbox(
                value: widget.team
                        .indexWhere((element) => element.id == userModel.id) >=
                    0,
                activeColor: Colors.green,
                onChanged: (value) {
                  widget.addUserTeam(userModel.id);
                  setState(() {});
                }),
          );
        },
      ),
    );
  }
}
