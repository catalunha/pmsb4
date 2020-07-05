import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/presentations/styles/pmsb_styles.dart';

class KanbanCardCreateOrUpdateTitleDescriptionDS extends StatefulWidget {
  final bool isCreate;
  final String title;
  final String description;
  final Function(String, String) onCreate;

  final Function(String, String, bool, bool) onUpdate;

  const KanbanCardCreateOrUpdateTitleDescriptionDS({
    Key key,
    this.isCreate,
    this.title,
    this.description,
    this.onCreate,
    this.onUpdate,
  }) : super(key: key);
  @override
  _KanbanCardCreateOrUpdateTitleDescriptionDSState createState() =>
      _KanbanCardCreateOrUpdateTitleDescriptionDSState();
}

class _KanbanCardCreateOrUpdateTitleDescriptionDSState
    extends State<KanbanCardCreateOrUpdateTitleDescriptionDS> {
  static final formKey = GlobalKey<FormState>();
  String _title;
  String _description;
  _KanbanCardCreateOrUpdateTitleDescriptionDSState();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height > 1000
        ? MediaQuery.of(context).size.height * 0.40
        : MediaQuery.of(context).size.height * 0.60;

    double _width = MediaQuery.of(context).size.width > 1000
        ? MediaQuery.of(context).size.width * 0.45
        : MediaQuery.of(context).size.width * 0.65;

    Dialog dialogWithImage = Dialog(
      child: Form(
        key: formKey,
        child: Container(
          color: PmsbColors.navbar,
          height: _height,
          width: _width,
          child: ListView(
            children: <Widget>[
              Container(
                width: _width,
                color: Colors.black12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 10,
                    ),
                    Container(
                      child: Text(
                          (widget.isCreate ? "Criar nova" : "Editar") +
                              " tarefa",
                          style: PmsbStyles.textStyleListPerfil01),
                    ),
                    IconButton(
                      hoverColor: Colors.white12,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Container(
                  color: Colors.white24,
                  height: 1,
                  width: _width,
                ),
              ),
              textoQuadro("Titulo da tarefa"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  initialValue: widget.title,
                  onSaved: (value) => _title = value,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.black12,
                  ),
                ),
              ),
              textoQuadro("Descrição da tarefa"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  initialValue: widget.description,
                  onSaved: (value) => _description = value,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.black12,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: PmsbColors.cor_destaque,
                    onPressed: () {
                      validateData();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                          color: PmsbColors.navbar,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
    return dialogWithImage;
  }

  Widget textoQuadro(String texto) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30),
      child: Text(
        texto,
        style: TextStyle(
          color: PmsbColors.texto_secundario,
          fontSize: 14,
        ),
      ),
    );
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (widget.isCreate) {
        widget.onCreate(_title, _description);
      } else {
        widget.onUpdate(_title, _description, null, null);
      }
    } else {
      setState(() {});
    }
  }
}
