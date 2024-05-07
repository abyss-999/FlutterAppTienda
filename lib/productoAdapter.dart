import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  late String nombre;
  late double precio;
  late List<String> imagen;

  Producto.fromFirestore(DocumentSnapshot doc) {
    nombre = doc['nombre'];
    precio = doc['precio'];
    imagen = List<String>.from(doc['imagen']);
    // Aquí puedes inicializar más campos si los tienes en tu documento
  }
}

class Carrito {
  late List<Producto> productos;

  Carrito() {
    productos = [];
  }

  agregarProducto(Producto producto) {
    productos.add(producto);
  }
}

class ProductoAdapter extends StatelessWidget {
  final List<Producto> productos;
  final Carrito carrito;

  ProductoAdapter({required this.productos, required this.carrito});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: productos[index].imagen.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: productos[index].imagen[0],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : null,
          title: Text(productos[index].nombre),
          subtitle: Text(productos[index].precio.toString()),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              carrito.agregarProducto(productos[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Producto añadido al carrito'),
                ),
              );
            },
          ),
        );
      },
    );
  }
}