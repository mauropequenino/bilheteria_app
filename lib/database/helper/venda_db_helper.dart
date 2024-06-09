import 'package:bilheteria_app/database/helper/db_helper.dart';
import 'package:bilheteria_app/model/venda_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class VendasDbHelper extends DbHelper {
  // Singleton pattern: Criação da instância única para ser reutilizada em todas as chamadas subsequent
  static final VendasDbHelper _instance = VendasDbHelper._internal();

  //Retornar a instância única da classe
  factory VendasDbHelper() => _instance;

  //impede a criação de instâncias adicionais da classe directamente.
  VendasDbHelper._internal();

  // Registar uma venda na base de dados
  Future<int> inserirVenda(VendaModel venda) async {
    try {
      Database db = await database;
      return await db.insert('vendas', venda.toMap());
    } catch (e) {
      print('Erro ao actualizar venda: $e');
      return -1;
    }
  }

  /* 
  Buscar todas vendas registados na base
  Retornar uma lista vazia em caso de erro
*/
  Future<List<VendaModel>> buscarVendas() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> maps = await db.query('vendas');
      return List.generate(maps.length, (i) {
        return VendaModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Erro ao buscar vendas: $e');
      return [];
    }
  }

  /* 
  Actualizar um venda registado na base de dados passando o objecto por porametro
  Retornar -1 em caso de erro
*/
  Future<int> actualizarVenda(VendaModel venda) async {
    try {
      Database db = await database;
      return await db.update(
        'vendas',
        venda.toMap(),
        where: 'id = ?',
        whereArgs: [venda.id],
      );
    } catch (e) {
      print('Erro ao actualizar venda: $e');
      return -1;
    }
  }

  /* 
  Remover uma venda registado na base de dados por id 
  Retornar -1 em caso de erro
*/
  Future<int> removerVenda(String id) async {
    try {
      Database db = await database;
      return await db.delete(
        'vendas',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Erro ao actualizar venda: $e');
      return -1;
    }
  }
}
