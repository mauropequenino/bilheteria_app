import 'package:bilheteria_app/database/helper/db_helper.dart';
import 'package:bilheteria_app/view/bilhete_screen.dart';
import 'package:bilheteria_app/view/cliente_screen.dart';
import 'package:bilheteria_app/view/home_screen.dart';
import 'package:bilheteria_app/view/venda_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  final dbHelper = DbHelper();
  dbHelper.initDatabase();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/bilhetes': (context) => BilheteScreen(),
        '/clientes': (context) => ClienteScreen(),
        '/vendas': (context) => VendaScreen()
      },
    );
  }
}
