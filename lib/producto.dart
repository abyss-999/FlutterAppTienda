import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  late String nombre;
  late List<String> imagen;
  late String categoria;
  late double precio;

  Producto.fromFirestore(DocumentSnapshot doc) {
    nombre = doc['nombre'];
    imagen = List<String>.from(doc['imagen']);
    categoria = doc['categoria'];
    precio = doc['precio'].toDouble();
  }
}
