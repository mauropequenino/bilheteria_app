import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

//Configurar e gerenciar banco de dados SQLite
class DbHelper {
  //Armazena a instância do banco de dados.
  static Database? _database;

  /// Retorna a instância do banco de dados.
  ///Se o banco de dados já foi inicializado, ele retorna a instância existente.
  /// Caso contrário, ele chama initDatabase() para inicializar o banco de dados.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  /// obtém o diretório de documentos da aplicação usando getApplicationDocumentsDirectory(),
  /// cria o caminho completo para o banco de dados e chama openDatabase() para abrir o banco de dados,
  /// especificando a versão e a função de callback _onCreate que será chamada quando o banco de dados for criado pela primeira vez.
  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'gestao_bilheteria.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bilhetes (
        id TEXT PRIMARY KEY,
        tituloEvento TEXT NOT NULL,
        descricao TEXT NOT NULL,
        localizacao TEXT NOT NULL,
        provincia TEXT NOT NULL,
        horaInicio TEXT NOT NULL,
        preco REAL NOT NULL,
        dataCriacao TEXT DEFAULT CURRENT_TIMESTAMP
      )
      ''');

    await db.execute('''
      CREATE TABLE clientes (
        id TEXT PRIMARY KEY,
        nome TEXT NOT NULL,
        dataCricao TEXT DEFAULT CURRENT_TIMESTAMP
      )
      ''');

    await db.execute('''
      CREATE TABLE vendas (
        id TEXT PRIMARY KEY,
        idCliente TEXT NOT NULL,
        idBilhete TEXT NOT NULL,
        quantidade INTEGER NOT NULL,
        total REAL NOT NULL,
        dataCriacao TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (idCliente) REFERENCES clientes(id)
        FOREIGN KEY (idBilhete) REFERENCES bilhetes(id)
      )
      ''');
  }

  ///remove o banco de dados deletando o arquivo físico correspondente no sistema de arquivos. 
  ///Ele obtém o diretório de documentos da aplicação, constrói o caminho completo para o banco de dados 
  ///e chama deleteDatabase() para deletar o arquivo do banco de dados.
  Future<void> removeDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'gestao_bilheteria.db');
    await deleteDatabase(path);
  }
}
