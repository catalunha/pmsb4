import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/team_board.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/components/input_text.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/presentations/styles/pmsb_styles.dart';

class KanbanBoardCRUDDS extends StatefulWidget {
  final bool isCreate;
  final String title;
  final String description;
  final bool public;
  final bool active;
  final List<Team> team;
  final Function(String) onRemoveUserTeam;
  final Function(String, String, bool, bool) onCreateOrUpdate;

  const KanbanBoardCRUDDS(
      {Key key,
      this.isCreate,
      this.title,
      this.description,
      this.public,
      this.active,
      this.team,
      this.onCreateOrUpdate,
      this.onRemoveUserTeam})
      : super(key: key);
  @override
  KanbanBoardCRUDDSState createState() {
    return KanbanBoardCRUDDSState();
    // return KanbanBoardCRUD2DSState(public, active);
  }
}

class KanbanBoardCRUDDSState extends State<KanbanBoardCRUDDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  bool _public;
  bool _active;

  // KanbanBoardCRUD2DSState() {
  //   // KanbanBoardCRUD2DSState(this._public, this._active) {
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _public = widget.public;
    _active = widget.active;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PmsbColors.fundo,
        elevation: 0,
        centerTitle: true,
        title: widget.isCreate ? Text('Criar quadro') : Text('Editar quadro'),
      ),
      backgroundColor: PmsbColors.fundo,
      // backToRootPage: false,
      body: body(),
    );
  }

  Widget body() {
    return Container(
      child: Column(
        children: <Widget>[Expanded(child: mainQuadro())],
      ),
    );
  }

  Widget mainQuadro() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.10,
        vertical: height * 0.01,
      ),
      child: Container(
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              textoTitulo("Crie um novo Quadro"),
              textoSubtitulo(
                  "Supervisione, gerencie e atualize seu trabalho em um só local, para que as tarefas continuem dentro do conograma."),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Container(
                  color: Colors.white24,
                  width: MediaQuery.of(context).size.width * 0.05,
                  height: 1,
                ),
              ),
              Padding(padding: EdgeInsets.all(7)),
              textoQuadro("Nome do Quadro"),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: InputText(
                  // title: 'Titulo do quadro',
                  initialValue: widget.title,
                  onSaved2: (value) => _title = value,
                ),
              ),
              Padding(padding: EdgeInsets.all(7)),
              textoQuadro("Descrição (Opcional)"),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: InputText(
                  // title: 'Descrição do quadro',
                  initialValue: widget.description,
                  onSaved2: (value) => _description = value,
                ),
              ),
              ListTile(
                title: textoQuadro('Quadro público ?'),
                subtitle: _public
                    ? textoSubtitulo(
                        'Qualquer pessoa pode ver este quadro. Mas apenas sua equipe pode editar.')
                    : textoSubtitulo('Somente sua equipe pode ver e editar.'),
                leading: Checkbox(
                  value: _public,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(
                      () {
                        _public = value;
                      },
                    );
                  },
                ),
              ),
              // textoQuadro(
              //     "Público ? Qualquer pessoa pode ver este quadro. Apenas sua equipe pode editar."),
              // Padding(
              //   padding: EdgeInsets.all(7),
              //   child: Checkbox(
              //     value: _public,
              //     activeColor: Colors.green,
              //     onChanged: (value) {
              //       setState(
              //         () {
              //           _public = value;
              //         },
              //       );
              //     },
              //   ),
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textoQuadro("Equipe"),
                  SizedBox(width: 5),
                  IconButton(
                    icon: Icon(
                      Icons.person_add,
                      size: 20,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => TeamBoard());
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Wrap(
                  children: avatarsTeam(),
                ),
              ),
              Padding(padding: EdgeInsets.all(7)),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.35),
                child: RaisedButton(
                  child: widget.isCreate ? Text('Criar') : Text('Atualizar'),
                  color: PmsbColors.cor_destaque,
                  onPressed: () {
                    validateData();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textoTitulo(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
            color: PmsbColors.texto_primario,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget textoSubtitulo(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
          color: PmsbColors.texto_terciario,
          fontSize: 17,
        ),
      ),
    );
  }

  Widget textoQuadro(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 7.0, bottom: 7.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
          color: PmsbColors.texto_secundario,
          fontSize: 18,
        ),
      ),
    );
  }

  List<Widget> avatarsTeam() {
    List<Widget> listaWidget = List<Widget>();
    for (var item in widget.team) {
      listaWidget.add(
        Padding(
          padding: EdgeInsets.all(5),
          child: InkWell(
            onTap: () {
              // //print('removendo user${item.id}');
              widget.onRemoveUserTeam(item.id);
            },
            child: Tooltip(
              message:
                  '${item.displayName} ${item.id.substring(0, 5)} . Clique para excluí-lo da equipe deste quadro.',
              child: CircleAvatar(
                backgroundColor: PmsbColors.navbar,
                minRadius: 20,
                maxRadius: 20,
                child: ClipOval(
                  child: Center(
                      child: item?.photoUrl != null
                          ? Image.network(item.photoUrl)
                          : Text(
                              item.displayName[0].toUpperCase() +
                                  item.displayName[1].toUpperCase(),
                              style: PmsbStyles.textoSecundario,
                            )),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return listaWidget;
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      widget.onCreateOrUpdate(_title, _description, _public, _active);
    } else {
      setState(() {});
    }
  }
}
