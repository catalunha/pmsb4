import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';
import 'package:pmsb4/presentations/styles/pmsb_styles.dart';

class FeedCardUpdateDS extends StatefulWidget {
  final String description;
  final String link;
  final Function(String, String) onUpdate;

  const FeedCardUpdateDS({Key key, this.description, this.link, this.onUpdate})
      : super(key: key);

  @override
  _FeedCardUpdateDSState createState() => _FeedCardUpdateDSState();
}

class _FeedCardUpdateDSState extends State<FeedCardUpdateDS> {
  static final formKey = GlobalKey<FormState>();
  String _description;
  String _link;

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
                      child: Text("Editar notícia",
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
              textoQuadro("Descrição da notícia"),
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
              textoQuadro("Link para esta notícia"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  initialValue: widget.link,
                  onSaved: (value) => _link = value,
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
      widget.onUpdate(_description, _link);
    } else {
      setState(() {});
    }
  }
}
