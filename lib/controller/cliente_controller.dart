import 'package:bilheteria_app/database/helper/cliente_db_helper.dart';
import 'package:bilheteria_app/model/cliente_model.dart';

///Gerenciar as operações relacionadas à tabela de clientes no banco de dados
///
class ClienteController {
  // Fornece uma interface para interagir com a tabela
  final ClienteDbHelper _databaseHelper = ClienteDbHelper();

  Future<void> adicionar(ClienteModel cliente) async {
    await _databaseHelper.inserirCliente(cliente);
  }

  Future<List<ClienteModel>> buscarTodos() async {
    return await _databaseHelper.buscarClientes();
  }

  Future<void> actualizar(ClienteModel cliente) async {
    await _databaseHelper.actualizarCliente(cliente);
  }

  Future<void> remover(String id) async {
    await _databaseHelper.removerCliente(id);
  }
}
