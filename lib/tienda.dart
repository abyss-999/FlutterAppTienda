import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'carrito.dart';

class TiendaPage extends StatefulWidget {
  final String? email;

  TiendaPage({Key? key, this.email}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State<TiendaPage> {
  String searchText = '';

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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Bienvenido, ${widget.email}', style: TextStyle(fontSize: 20)),
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
          child: Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
