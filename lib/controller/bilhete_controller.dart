

import 'package:bilheteria_app/database/helper/bilhete_db_helper.dart';
import 'package:bilheteria_app/model/bilhete_model.dart';

class BilheteController {
  final BilheteDbHelper _databaseHelper = BilheteDbHelper();

  Future<void> addBilhete(BilheteModel bilhete) async {
    await _databaseHelper.inserirBilhete(bilhete);
  }

  Future<List<BilheteModel>> fetchBilhetes() async {
    return await _databaseHelper.buscarBilhetes();
  }

  Future<void> updateBilhete(BilheteModel bilhete) async {
    await _databaseHelper.actualizarBilhete(bilhete);
  }

  Future<void> deleteBilhete(String id) async {
    await _databaseHelper.removerBilhete(id);
  }
}
