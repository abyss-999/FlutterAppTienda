import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TenisPage extends StatefulWidget {
  @override
  _TenisState createState() => _TenisState();
}

class _TenisState extends State<TenisPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Producto> productos = [];

  @override
  void initState() {
    super.initState();
    fetchTenis();
  }

  fetchTenis() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('Productos')
          .where('categoria', isEqualTo: 'tenis')
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
        title: Text('Tenis'),
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
