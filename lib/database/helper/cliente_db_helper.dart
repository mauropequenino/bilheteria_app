import 'package:bilheteria_app/database/helper/db_helper.dart';
import 'package:bilheteria_app/model/cliente_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class ClienteDbHelper extends DbHelper {
  // Singleton pattern: Criação da instância única para ser reutilizada em todas as chamadas subsequent
  static final ClienteDbHelper _instance = ClienteDbHelper._internal();

  //Retornar a instância única da classe
  factory ClienteDbHelper() => _instance;

  //impede a criação de instâncias adicionais da classe directamente.
  ClienteDbHelper._internal();

// Registar cliente na base de dados
  Future<int> inserirCliente(ClienteModel cliente) async {
    try {
      Database db = await database;
      return await db.insert('clientes', cliente.toMap());
    } catch (e) {
      print('Erro ao actualizar cliente: $e');
      return -1;
    }
  }

  /* 
  Buscar todos clientes registados na base
  Retornar uma lista vazia em caso de erro
*/
  Future<List<ClienteModel>> buscarClientes() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> maps = await db.query('clientes');
      return List.generate(maps.length, (i) {
        return ClienteModel.fromMap(maps[i]);
      });
    } catch (e) {
      print('Erro ao buscar clientes: $e');
      return [];
    }
  }

  /* 
  Actualizar um cliente registado na base de dados passando o objecto por porametro
  Retornar -1 em caso de erro
*/
  Future<int> actualizarCliente(ClienteModel cliente) async {
    try {
      Database db = await database;
      return await db.update(
        'clientes',
        cliente.toMap(),
        where: 'id = ?',
        whereArgs: [cliente.id],
      );
    } catch (e) {
      print('Erro ao actualizar cliente: $e');
      return -1;
    }
  }

  /* 
  Remover um cliente registado na base de dados por id 
  Retornar -1 em caso de erro
*/
  Future<int> removerCliente(String id) async {
    try {
      Database db = await database;
      return await db.delete(
        'clientes',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Erro ao actualizar cliente: $e');
      return -1;
    }
  }
}
