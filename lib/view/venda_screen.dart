import 'package:bilheteria_app/controller/cliente_controller.dart';
import 'package:bilheteria_app/model/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:bilheteria_app/controller/venda_controller.dart';
import 'package:bilheteria_app/model/venda_model.dart';
import 'package:bilheteria_app/model/bilhete_model.dart';
import 'package:bilheteria_app/controller/bilhete_controller.dart';
import 'package:uuid/uuid.dart';

class VendaScreen extends StatefulWidget {
  @override
  _VendaScreenState createState() => _VendaScreenState();
}

class _VendaScreenState extends State<VendaScreen> {
  final VendaController _controller = VendaController();
  final BilheteController _bilheteController = BilheteController();
  final ClienteController _clienteController = ClienteController();
  

  List<VendaModel> _vendas = [];
  List<BilheteModel> _bilhetes = [];
  List<ClienteModel> _clientes = [];
  String? _selectedIdBilhete;
  String? _selectedIdIdCliente;

  @override
  void initState() {
    super.initState();
    _fetchVendas();
    _fetchBilhetes();
    _fetchClientes();
  }

  Future<void> _fetchVendas() async {
    List<VendaModel> vendas = await _controller.buscarTodos();
    setState(() {
      _vendas = vendas;
    });
  }

  Future<void> _fetchBilhetes() async {
    List<BilheteModel> bilhetes = await _bilheteController.buscarTodos();
    setState(() {
      _bilhetes = bilhetes;
    });
  }

  Future<void> _fetchClientes() async {
    List<ClienteModel> clientes = await _clienteController.buscarTodos();
    setState(() {
      _clientes = clientes;
    });
  }

  void _showVendaDialog({VendaModel? venda}) {
    final _formKey = GlobalKey<FormState>();
    final _idController =
        TextEditingController(text: venda?.id ?? const Uuid().v4());
    final _quantidadeController =
        TextEditingController(text: venda?.quantidade.toString() ?? '');
    final _precoUnitarioController = TextEditingController();
    final _precoTotalController =
        TextEditingController(text: venda?.precoTotal.toString() ?? '');

    void _updatePrecoUnitario(String? bilheteId) {
      BilheteModel? bilhete =
          _bilhetes.firstWhere((b) => b.id == bilheteId);

        setState(() {
          _precoUnitarioController.text = bilhete.preco.toString();
        });
    }


    if (venda != null) {
      _selectedIdBilhete = venda.idBilhette;
      _selectedIdIdCliente = venda.idCliente;
      _updatePrecoUnitario(venda.idBilhette);
    }

    _quantidadeController.addListener(() {
      double precoUnitario =
          double.tryParse(_precoUnitarioController.text) ?? 0.0;
      int quantidade = int.tryParse(_quantidadeController.text) ?? 0;
      double precoTotal = precoUnitario * quantidade;
      _precoTotalController.text = precoTotal.toStringAsFixed(2);
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(venda == null ? 'Adicionar Venda' : 'Editar Venda'),
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
                  DropdownButtonFormField<String>(
                    value: _selectedIdBilhete,
                    items: _bilhetes.map((BilheteModel bilhete) {
                      return DropdownMenuItem<String>(
                        value: bilhete.id,
                        child: Text(bilhete.tituloEvento),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Bilhete',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedIdBilhete = newValue;
                      });
                      _updatePrecoUnitario(newValue);
                    },

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor selecione um bilhete';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedIdIdCliente,
                    items: _clientes.map((ClienteModel cliente) {
                      return DropdownMenuItem<String>(
                        value: cliente.id,
                        child: Text(cliente.nome),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Cliente',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedIdIdCliente = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor selecione um cliente';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _quantidadeController,
                    decoration: InputDecoration(
                      labelText: 'Quantidade',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor insira a quantidade';
                      }
                      final int? quantidade = int.tryParse(value);
                      if (quantidade == null) {
                        return 'Por favor insira um número válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    controller: _precoUnitarioController,
                    decoration: InputDecoration(
                      labelText: 'Preço Unitário',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    enabled: false,
                    controller: _precoTotalController,
                    decoration: InputDecoration(
                      labelText: 'Preço Total',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
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
              child: Text('Registar'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  VendaModel novaVenda = VendaModel(
                      id: _idController.text,
                      idCliente: _selectedIdIdCliente!,
                      idBilhette: _selectedIdBilhete!,
                      quantidade: int.parse(_quantidadeController.text),
                      precoTotal: double.parse(_precoTotalController.text),
                      //dataCricao: DateTime.now().toString()
                    );
                  if (venda == null) {
                    await _controller.adicionar(novaVenda);
                  } else {
                    await _controller.actualizar(novaVenda);
                  }
                  _fetchVendas();
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
        title: Text('Vendas de Bilhetes'),
      ),
      body: ListView.builder(
        itemCount: _vendas.length,
        itemBuilder: (context, index) {
          final venda = _vendas[index];
          return ListTile(
            title: Text(venda.id),
            subtitle: Text(
                '${venda.idBilhette} - ${venda.quantidade} - ${venda.precoTotal}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _showVendaDialog(venda: venda);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await _controller.remover(venda.id);
                    _fetchVendas();
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showVendaDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
