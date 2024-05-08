import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChaquetasPage extends StatefulWidget {
  @override
  _ChaquetasState createState() => _ChaquetasState();
}

class _ChaquetasState extends State<ChaquetasPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    fetchChaquetas();
  }

  fetchChaquetas() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('Productos')
          .where('categoria', isEqualTo: 'chaquetas')
          .get();
      List<Producto> productos =
          snapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList();
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
        title: Text('Chaquetas'),
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
