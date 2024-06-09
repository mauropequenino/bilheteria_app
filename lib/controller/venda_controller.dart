import 'package:bilheteria_app/database/helper/venda_db_helper.dart';
import 'package:bilheteria_app/model/venda_model.dart';


///Gerenciar as operações relacionadas à tabela de vendas no banco de dados

class VendaController {
  // Fornece uma interface para interagir com a tabela
  final VendasDbHelper _databaseHelper = VendasDbHelper();

  Future<void> adicionar(VendaModel venda) async {
    await _databaseHelper.inserirVenda(venda);
  }

  Future<List<VendaModel>> buscarTodos() async {
    return await _databaseHelper.buscarVendas();
  }

  Future<void> actualizar(VendaModel venda) async {
    await _databaseHelper.actualizarVenda(venda);
  }

  Future<void> remover(String id) async {
    await _databaseHelper.removerVenda(id);
  }
}
