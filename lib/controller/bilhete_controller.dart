import 'package:bilheteria_app/database/helper/bilhete_db_helper.dart';
import 'package:bilheteria_app/model/bilhete_model.dart';

///Gerenciar as operações relacionadas à tabela de bilhetes no banco de dados

class BilheteController {
  // Fornece uma interface para interagir com a tabela
  final BilheteDbHelper _databaseHelper = BilheteDbHelper();

  Future<void> adicionar(BilheteModel bilhete) async {
    await _databaseHelper.inserirBilhete(bilhete);
  }

  Future<List<BilheteModel>> buscarTodos() async {
    return await _databaseHelper.buscarBilhetes();
  }

  Future<void> actualizar(BilheteModel bilhete) async {
    await _databaseHelper.actualizarBilhete(bilhete);
  }

  Future<void> remover(String id) async {
    await _databaseHelper.removerBilhete(id);
  }
}
