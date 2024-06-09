import 'package:bilheteria_app/controller/cliente_controller.dart';
import 'package:bilheteria_app/model/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ClienteScreen extends StatefulWidget {
  @override
  _ClienteScreenState createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  final ClienteController _controller = ClienteController();
  List<ClienteModel> _clientes = [];

  @override
  void initState() {
    super.initState();
    _fetchClientes();
  }

  Future<void> _fetchClientes() async {
    List<ClienteModel> clientes = await _controller.buscarTodos();
    setState(() {
      _clientes = clientes;
    });
  }

  void _showClienteDialog({ClienteModel? cliente}) {
    final _formKey = GlobalKey<FormState>();
    final _idController =
        TextEditingController(text: cliente?.id ?? const Uuid().v4());
    final _nomeController = TextEditingController(text: cliente?.nome ?? '');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(cliente == null ? 'Adicionar Cliente' : 'Editar Cliente'),
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
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira o nome do cliente';
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
                  ClienteModel novoCliente = ClienteModel(
                    id: _idController.text,
                    nome: _nomeController.text,
                    //dataCriacao: DateTime.now().toString(),
                  );
                  if (cliente == null) {
                    await _controller.adicionar(novoCliente);
                  } else {
                    await _controller.actualizar(novoCliente);
                  }
                  _fetchClientes();
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
        title: Text('Clientes'),
      ),
      body: ListView.builder(
        itemCount: _clientes.length,
        itemBuilder: (context, index) {
          final cliente = _clientes[index];
          return ListTile(
            title: Text(cliente.nome),
            subtitle: Text('${cliente.nome}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showClienteDialog(cliente: cliente);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _controller.remover(cliente.id);
                    _fetchClientes();
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
          _showClienteDialog();
        },
      ),
    );
  }
}
