import 'package:bilheteria_app/database/helper/home_db_helper.dart';


//Interagir com métodos do banco de dados e obter dados agregados das tabelas bilhetes, clientes e vendas

class HomeController {
    // Fornece uma interface para interagir com os metodos
  final HomeDbHelper _databaseHelper = HomeDbHelper();

  Future<Map<String, int>> getDataBaseDados() async {
    int totalBilhetes = await _databaseHelper.getTotalBilhetes();
    int totalClientes = await _databaseHelper.getTotalClientes();
    int totalVendas = await _databaseHelper.getTotalVendas();

    return {
      'totalBilhetes': totalBilhetes,
      'totalClientes': totalClientes,
      'totalVendas': totalVendas,
    };
  }
}
