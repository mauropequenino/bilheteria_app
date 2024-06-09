import 'package:bilheteria_app/controller/bilhete_controller.dart';
import 'package:bilheteria_app/model/bilhete_model.dart';
import 'package:bilheteria_app/view/widgets/dropdown_button.dart';
import 'package:bilheteria_app/view/widgets/pick_time.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class BilheteScreen extends StatefulWidget {
  @override
  _BilheteScreenState createState() => _BilheteScreenState();
}

class _BilheteScreenState extends State<BilheteScreen> {
  final BilheteController _controller = BilheteController();
  List<BilheteModel> _bilhetes = [];

  List<String> _provincias = [
    'Maputo',
    'Gaza',
    'Inhambane',
    'Sofala',
    'Manica',
    'Tete',
    'Zambézia',
    'Nampula',
    'Niassa',
    'Cabo Delgado'
  ];

  @override
  void initState() {
    super.initState();
    _fetchBilhetes();
  }

  Future<void> _fetchBilhetes() async {
    List<BilheteModel> bilhetes = await _controller.buscarTodos();
    setState(() {
      _bilhetes = bilhetes;
    });
  }

  void _showBilheteDialog({BilheteModel? bilhete}) {
    final _formKey = GlobalKey<FormState>();
    final _idController =
        TextEditingController(text: bilhete?.id ?? const Uuid().v4());
    final _tituloController =
        TextEditingController(text: bilhete?.tituloEvento ?? '');
    final _descricaoController =
        TextEditingController(text: bilhete?.descricao ?? '');
    final _localizacaoController =
        TextEditingController(text: bilhete?.localizacao ?? '');
    var _provinciaController = bilhete?.provincia ?? '';
    TextEditingController(text: bilhete?.provincia ?? '');
    final _horaInicioController =
        TextEditingController(text: bilhete?.horaInicio ?? '');
    final _precoController = TextEditingController(
        text: bilhete?.preco != null ? bilhete?.preco.toString() : '');

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
                    enabled: false,
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _tituloController,
                    decoration: InputDecoration(
                      labelText: 'Título do Evento',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o título do evento';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descricaoController,
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a descrição';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _localizacaoController,
                    decoration: InputDecoration(
                      labelText: 'Localização',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a localização';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonCombBox(
                    typeValue: 'Provincia',
                    values: _provincias,
                    selectedValue: _provinciaController,
                    onChanged: (value) => setState(() {
                      _provinciaController = value!;
                    }),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => pickTime(context,
                        _horaInicioController), 
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: _horaInicioController,
                        decoration: InputDecoration(
                          labelText: 'Hora de Início',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor insira a hora de início';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _precoController,
                    decoration: InputDecoration(
                      labelText: 'Preço',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o preço';
                      }
                      final double? preco = double.tryParse(value);
                      if (preco == null) {
                        return 'Por favor insira um número válido';
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
                    provincia: _provinciaController,
                    horaInicio: _horaInicioController.text,
                    preco: double.parse(_precoController.text),
                    dataCricao: DateTime.now().toString(),
                  );
                  if (bilhete == null) {
                    await _controller.adicionar(novoBilhete);
                  } else {
                    await _controller.actualizar(novoBilhete);
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
                    await _controller.remover(bilhete.id);
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
