import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pantalones extends StatefulWidget {
  @override
  _PantalonesState createState() => _PantalonesState();
}

class _PantalonesState extends State<Pantalones> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    fetchPantalones();
  }

  fetchPantalones() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('Productos')
          .where('categoria', isEqualTo: 'pantalones')
          .get();
      List<Producto> productos = snapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList();
      setState(() {
        this.productos = productos;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalones'),
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productos[index].nombre),
            // Aquí puedes agregar más detalles sobre cada producto
          );
        },
      ),
    );
  }
}

class Producto {
  late String nombre;

  Producto.fromFirestore(DocumentSnapshot doc) {
    nombre = doc['nombre'];
    // Aquí puedes inicializar más campos si los tienes en tu documento
  }
}