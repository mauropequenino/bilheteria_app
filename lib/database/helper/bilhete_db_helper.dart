import 'package:bilheteria_app/database/helper/db_helper.dart';
import 'package:bilheteria_app/model/bilhete_model.dart';
import 'dart:async';

class BilheteDbHelper extends DbHelper {
  // Singleton pattern: Criação da instância única para ser reutilizada em todas as chamadas subsequentes.
  static final BilheteDbHelper _instance = BilheteDbHelper._internal();

  //Retornar a instância única da classe
  factory BilheteDbHelper() => _instance;

  //impede a criação de instâncias adicionais da classe directamente.
  BilheteDbHelper._internal();

  // Registar bilhete na base de dados
  Future<int> inserirBilhete(BilheteModel bilhete) async {
    try {
      final db = await database;
      return await db.insert('bilhetes', bilhete.toMap());
    } catch (e) {
      print('Erro ao inserir bilhete: $e');
      return -1;
    }
  }

  /* 
  Buscar todos bilhetes registados na base
  Retornar uma lista vazia em caso de erro
*/
  Future<List<BilheteModel>> buscarBilhetes() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('bilhetes');
      return List.generate(maps.length, (i) {
        return BilheteModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Erro ao buscar bilhetes: $e');
      return [];
    }
  }

  /* 
  Actualizar um bilhete registado na base de dados passando o objecto por porametro
  Retornar -1 em caso de erro
*/
  Future<int> actualizarBilhete(BilheteModel bilhete) async {
    try {
      final db = await database;
      return await db.update(
        'bilhetes',
        bilhete.toMap(),
        where: 'id = ?',
        whereArgs: [bilhete.id],
      );
    } catch (e) {
      print('Erro ao actualizar bilhete: $e');
      return -1;
    }
  }

  /* 
  Remover um bilhete registado na base de dados por id 
  Retornar -1 em caso de erro
*/
  Future<int> removerBilhete(String id) async {
    try {
      final db = await database;
      return await db.delete(
        'bilhetes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Erro ao remover bilhete: $e');
      return -1;
    }
  }
}
