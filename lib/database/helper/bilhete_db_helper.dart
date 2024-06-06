import 'dart:io' as io;
import 'package:bilheteria_app/model/bilhete_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class BilheteDbHelper {
  static final BilheteDbHelper _instance = BilheteDbHelper._internal();
  factory BilheteDbHelper() => _instance;
  static Database? _database;

  BilheteDbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'gestao_bilheteria.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bilhetes (
        id TEXT PRIMARY KEY,
        tituloEvento TEXT,
        descricao TEXT,
        localizacao TEXT,
        provincia TEXT,
        horaInicio TEXT,
        preco TEXT
      )
      ''');
  }

  Future<int> inserirBilhete(BilheteModel bilhete) async {
    Database db = await database;
    return await db.insert('bilhetes', bilhete.toMap());
  }

  Future<List<BilheteModel>> buscarBilhetes() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('bilhetes');
    return List.generate(maps.length, (i) {
      return BilheteModel.fromMap(maps[i]);
    });
  }

  Future<int> actualizarBilhete(BilheteModel bilhete) async {
    Database db = await database;
    return await db.update(
      'bilhetes',
      bilhete.toMap(),
      where: 'id = ?',
      whereArgs: [bilhete.id],
    );
  }

  Future<int> removerBilhete(String id) async {
    Database db = await database;
    return await db.delete(
      'bilhetes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
