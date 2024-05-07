import 'package:flutter/material.dart';
import 'producto_carrito.dart'; 

class Carrito extends StatelessWidget {
  final List<ProductoCarrito> productosCarrito = []; // Aquí debes poner tus productos del carrito

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: productosCarrito.isEmpty
          ? Center(child: Text('Tu carrito está vacío'))
          : ListView.builder(
              itemCount: productosCarrito.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.shopping_cart), 
                  title: Text(productosCarrito[index].producto.nombre),
                  trailing: Text('${productosCarrito[index].cantidad}'), 
                );
              },
            ),
    );
  }
}