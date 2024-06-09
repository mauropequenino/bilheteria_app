import 'package:bilheteria_app/controller/home_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 50.0, bottom: 25.0),
                  child: ListTile(
                    title: Text(
                      "GESTAO DE BILHETES",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.local_activity,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Bilhetes',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/bilhetes'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Clientes",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/clientes'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.sell,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Vendas",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => Navigator.pushNamed(context, '/vendas'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.assessment,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Relatórios",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () => {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      ///FutureBuilder para construir uma interface de usuário que exibe dados agregados de bilhetes, clientes e vendas. 
      ///Enquanto os dados estão a carregar, um indicador de progresso é mostrado. 
      ///Se houver um erro, uma mensagem de erro é exibida. 
      ///Quando os dados estão disponíveis, eles são exibidos em uma lista de cartões coloridos.
      body: FutureBuilder<Map<String, int>>(
        future: _controller.getDataBaseDados(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var data = snapshot.data!;
            int totalBilhetes = data['totalBilhetes']!;
            int totalClientes = data['totalClientes']!;
            int totalVendas = data['totalVendas']!;

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildCard(
                  color: Colors.blue,
                  title: 'Total de Bilhetes',
                  count: totalBilhetes,
                ),
                SizedBox(height: 16),
                _buildCard(
                  color: Colors.green,
                  title: 'Total de Clientes',
                  count: totalClientes,
                ),
                SizedBox(height: 16),
                _buildCard(
                  color: Colors.orange,
                  title: 'Total de Vendas',
                  count: totalVendas,
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildCard({
    required Color color,
    required String title,
    required int count,
  }) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              '$count',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
