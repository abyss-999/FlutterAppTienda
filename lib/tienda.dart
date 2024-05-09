import 'package:flutter/material.dart';
import 'carrito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class TiendaPage extends StatefulWidget {
  final String? nombre;

  TiendaPage({Key? key, this.nombre}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<TiendaPage> {
  String searchText = '';

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> confirmAndLogout() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar'),
          content: Text('¿Estás seguro de que quieres cerrar la sesión?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
  child: Text('Sí'),
  onPressed: () {
    logout().then((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    });
  },
),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TIENDA DE ROPA', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Carrito(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: confirmAndLogout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Bienvenido, ${widget.nombre}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                labelText: "Buscar",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  if (searchText == '' || 'camisas'.contains(searchText))
                    createGridItem('Camisas', '/camisas'),
                  if (searchText == '' || 'chaquetas'.contains(searchText))
                    createGridItem('Chaquetas', '/chaquetas'),
                  if (searchText == '' || 'pantalones'.contains(searchText))
                    createGridItem('Pantalones', '/pantalones'),
                  if (searchText == '' || 'tenis'.contains(searchText))
                    createGridItem('Tenis', '/tenis'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createGridItem(String title, String route) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/$title.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}