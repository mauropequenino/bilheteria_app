import 'package:bilheteria_app/controller/bilhete_controller.dart';
import 'package:bilheteria_app/model/bilhete_model.dart';
import 'package:flutter/material.dart';

class BilheteScreen extends StatefulWidget {
  @override
  _BilheteScreenState createState() => _BilheteScreenState();
}

class _BilheteScreenState extends State<BilheteScreen> {
  final BilheteController _controller = BilheteController();
  List<BilheteModel> _bilhetes = [];

  @override
  void initState() {
    super.initState();
    _fetchBilhetes();
  }

  Future<void> _fetchBilhetes() async {
    List<BilheteModel> bilhetes = await _controller.fetchBilhetes();
    setState(() {
      _bilhetes = bilhetes;
    });
  }

  void _showBilheteDialog({BilheteModel? bilhete}) {
    final _formKey = GlobalKey<FormState>();
    final _idController = TextEditingController(text: bilhete?.id ?? '');
    final _tituloController =
        TextEditingController(text: bilhete?.tituloEvento ?? '');
    final _descricaoController =
        TextEditingController(text: bilhete?.descricao ?? '');
    final _localizacaoController =
        TextEditingController(text: bilhete?.localizacao ?? '');
    final _provinciaController =
        TextEditingController(text: bilhete?.provincia ?? '');
    final _horaInicioController =
        TextEditingController(text: bilhete?.horaInicio ?? '');
    final _precoController = TextEditingController(text: bilhete?.preco ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(bilhete == null ? 'Adicionar Bilhete' : 'Editar Bilhete'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(labelText: 'ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _tituloController,
                    decoration: InputDecoration(labelText: 'Título do Evento'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o título do evento';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a descrição';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _localizacaoController,
                    decoration: InputDecoration(labelText: 'Localização'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a localização';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _provinciaController,
                    decoration: InputDecoration(labelText: 'Província'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a província';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _horaInicioController,
                    decoration: InputDecoration(labelText: 'Hora de Início'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a hora de início';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _precoController,
                    decoration: InputDecoration(labelText: 'Preço'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o preço';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  BilheteModel novoBilhete = BilheteModel(
                    id: _idController.text,
                    tituloEvento: _tituloController.text,
                    descricao: _descricaoController.text,
                    localizacao: _localizacaoController.text,
                    provincia: _provinciaController.text,
                    horaInicio: _horaInicioController.text,
                    preco: _precoController.text,
                  );
                  if (bilhete == null) {
                    await _controller.addBilhete(novoBilhete);
                  } else {
                    await _controller.updateBilhete(novoBilhete);
                  }
                  _fetchBilhetes();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilhetes'),
      ),
      body: ListView.builder(
        itemCount: _bilhetes.length,
        itemBuilder: (context, index) {
          final bilhete = _bilhetes[index];
          return ListTile(
            title: Text(bilhete.tituloEvento),
            subtitle: Text('${bilhete.localizacao} - ${bilhete.provincia}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showBilheteDialog(bilhete: bilhete);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _controller.deleteBilhete(bilhete.id);
                    _fetchBilhetes();
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
          _showBilheteDialog();
        },
      ),
    );
  }
}
