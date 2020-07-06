import 'package:flutter/material.dart';
import 'package:pmsb4/presentations/styles/pmsb_colors.dart';

class FeedCardCreateDS extends StatefulWidget {
  final Function(String, String) onCreate;

  const FeedCardCreateDS({Key key, this.onCreate}) : super(key: key);
  @override
  _FeedCardCreateDSState createState() => _FeedCardCreateDSState();
}

class _FeedCardCreateDSState extends State<FeedCardCreateDS> {
  // TextEditingController textController;
  Widget caixaDeEntrada;
  bool entrada;
  static final formKey = GlobalKey<FormState>();
  String _description;
  String _link;
  @override
  initState() {
    this.entrada = true;
    this.caixaDeEntrada = caixaTexto();
    // this.textController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 5),
                this.caixaDeEntrada,
                SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    botaoAdicionarLink(),
                    RaisedButton(
                        child: Text("Salvar"),
                        color: PmsbColors.cor_destaque,
                        onPressed: () {
                          validateData();
                          // widget.onCreate('_description', '_link');
                          // widget.onCreate(_description, _link);
                        }),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateData() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print('validateData feed');
      widget.onCreate(_description, _link);
      _description = null;
      _link = null;
    } else {
      setState(() {});
    }
  }

  Widget caixaTextoLink() {
    return Container(
      // padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: PmsbColors.card, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Descrição do link:",
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                fillColor: Colors.black12,
                border: InputBorder.none,
              ),
              initialValue: _description,
              onSaved: (value) => _description = value,
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: PmsbColors.card, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextFormField(
              style: TextStyle(color: Colors.black),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Link:",
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
                fillColor: Colors.blue,
                border: InputBorder.none,
              ),
              initialValue: _link,
              onSaved: (value) => _link = value,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget caixaTexto() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: PmsbColors.card, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      padding: EdgeInsets.all(15),
      child: Center(
        child: TextFormField(
          autofocus: false,
          style: TextStyle(color: Colors.black),
          // controller: textController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            hintText: "Comentário",
            hintStyle: TextStyle(fontSize: 12, color: Colors.grey[600]),
            border: InputBorder.none,
          ),
          initialValue: _description,
          onSaved: (value) {
            _description = value;
          },
        ),
      ),
    );
  }

  botaoAdicionarLink() {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            setState(() {
              this.entrada = !this.entrada;
              this.caixaDeEntrada =
                  this.entrada ? this.caixaTexto() : this.caixaTextoLink();
            });
          },
          child: Row(
            children: <Widget>[
              SizedBox(width: 5),
              Text(
                this.entrada ? "Adicionar Link" : "Adicionar Comentario",
                style: TextStyle(color: PmsbColors.texto_secundario),
              ),
              SizedBox(width: 5),
              Icon(this.entrada ? Icons.link : Icons.text_fields),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
