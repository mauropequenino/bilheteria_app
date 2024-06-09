import 'package:bilheteria_app/database/helper/db_helper.dart';
import 'package:sqflite/sqflite.dart';

class HomeDbHelper extends DbHelper {
    // Singleton pattern: Criação da instância única para ser reutilizada em todas as chamadas subsequent
  static final HomeDbHelper _instance = HomeDbHelper._internal();
  
  //Retornar a instância única da classe
  factory HomeDbHelper() => _instance;
  
  //impede a criação de instâncias adicionais da classe directamente.
  HomeDbHelper._internal();

  Future<int> getTotalBilhetes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) FROM bilhetes');
    final int count = Sqflite.firstIntValue(result)!;
    return count;
  }

  Future<int> getTotalClientes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) FROM clientes');
    final int count = Sqflite.firstIntValue(result)!;
    return count;
  }

  Future<int> getTotalVendas() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) FROM vendas');
    final int count = Sqflite.firstIntValue(result)!;
    return count;
  }
}
