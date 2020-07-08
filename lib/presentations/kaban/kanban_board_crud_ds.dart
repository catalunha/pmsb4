import 'package:flutter/material.dart';
import 'package:pmsb4/containers/kanban/team_board.dart';
import 'package:pmsb4/models/types_models.dart';
import 'package:pmsb4/presentations/components/input_text.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

import '../styles/pmsb_colors.dart';
import '../styles/pmsb_colors.dart';
import '../styles/pmsb_colors.dart';
import '../styles/pmsb_styles.dart';

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
  int _botaoradioSelecionado;

  // KanbanBoardCRUD2DSState() {
  //   // KanbanBoardCRUD2DSState(this._public, this._active) {
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _public = widget.public;
    _active = widget.active;
    if (widget.isCreate) {
      _botaoradioSelecionado = 2;
    } else {
      _botaoradioSelecionado = _public ? 1 : 2;
    }
    //_botaoradioSelecionado = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PmsbColors.fundo,
        centerTitle: true,
        title: widget.isCreate ? Text('Criar Quadro') : Text('Editar Quadro'),
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
        //vertical: height * 0.02,
      ),
      child: Container(
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              // textoTitulo("Crie um novo Quadro"),
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
              Padding(padding: EdgeInsets.all(15)),
              textoQuadro("Nome do Quadro"),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: InputText(
                  // title: 'Titulo do quadro',
                  initialValue: widget.title,
                  onSaved2: (value) => _title = value,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              textoQuadro("Descrição (Opcional)"),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: InputText(
                  // title: 'Descrição do quadro',
                  initialValue: widget.description,
                  onSaved2: (value) => _description = value,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    RadioListTile(
                      title: Text(
                        "Público",
                        style: PmsbStyles.textoPrimario,
                      ),
                      subtitle: Text(
                        "Qualquer pessoa pode ver este quadro e suas tarefas. Apenas sua equipe pode editar o quadro e as tarefas.",
                        style: PmsbStyles.textoSecundario,
                      ),
                      value: 1,
                      groupValue: _botaoradioSelecionado,
                      activeColor: PmsbColors.cor_destaque,
                      onChanged: (val) {
                        setBotaoRadioSelecionado(val);
                      },
                    ),
                    RadioListTile(
                      title: Text(
                        "Privado",
                        style: PmsbStyles.textoPrimario,
                      ),
                      subtitle: Text(
                          "Apenas sua equipe pode ver e editar este quadro e suas tarefas."),
                      value: 2,
                      groupValue: _botaoradioSelecionado,
                      activeColor: PmsbColors.cor_destaque,
                      onChanged: (val) {
                        setBotaoRadioSelecionado(val);
                      },
                    ),
                  ],
                ),
              ),
              /* ListTile(
                title: textoQuadro("Público"),
                subtitle: _public
                    ? textoSubtitulo(
                        'Qualquer pessoa pode ver este quadro. Mas apenas sua equipe pode editar.')
                    : textoSubtitulo('Somente sua equipe pode ver e editar.'),
                leading: Checkbox(
                  value: _public,
                  activeColor: PmsbColors.cor_destaque,
                  onChanged: (value) {
                    setState(
                      () {
                        _public = value;
                      },
                    );
                  },
                ),
              ),
              */

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
              Wrap(
                children: avatarsTeam(),
              ),
              Padding(padding: EdgeInsets.all(7)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: widget.isCreate
                        ? Text('Criar Quadro')
                        : Text('Atualizar Quadro'),
                    color: PmsbColors.cor_destaque,
                    onPressed: () {
                      validateData();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textoTitulo(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30),
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
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30),
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
        InkWell(
          onTap: () {
            // print('removendo user${item.id}');
            widget.onRemoveUserTeam(item.id);
          },
          child: Tooltip(
            message:
                '${item.displayName} ${item.id.substring(0, 5)} . Clique para excluí-lo da equipe deste quadro.',
            child: Stack(
              children: [
                CircleAvatar(
                  minRadius: 20,
                  maxRadius: 20,
                  child: ClipOval(
                    child: Center(
                      child: item?.photoUrl != null
                          ? Image.network(item.photoUrl)
                          : Icon(Icons.person_add),
                    ),
                  ),
                ),
                Icon(
                  Icons.remove_red_eye,
                  color: item?.readedCard ?? true
                      ? Colors.transparent
                      : Colors.red,
                ),
              ],
            ),
          ),
        ),
      );
    }
    return listaWidget;
  }

  setBotaoRadioSelecionado(int val) {
    setState(() {
      _botaoradioSelecionado = val;
      if (val == 1) {
        _public = true;
      } else if (val == 2) {
        _public = false;
      }
    });
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
