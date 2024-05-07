import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Producto {
  final String nombre;
  final double precio;
  final List<String> imagen;

  Producto({required this.nombre, required this.precio, required this.imagen});
}

class ProductoCarrito {
  final Producto producto;
  final int cantidad;

  ProductoCarrito({required this.producto, required this.cantidad});
}

class CarritoAdapter extends StatelessWidget {
  final List<ProductoCarrito> productos;

  CarritoAdapter({required this.productos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: productos[index].producto.imagen.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: productos[index].producto.imagen[0],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                )
              : null,
          title: Text(productos[index].producto.nombre),
          subtitle: Text('Cantidad: ${productos[index].cantidad.toString()}'),
          trailing: IconButton(
            icon: Icon(Icons.remove_shopping_cart),
            onPressed: () {
              productos.removeAt(index);
              (context as Element).rebuild();
            },
          ),
        );
      },
    );
  }
}