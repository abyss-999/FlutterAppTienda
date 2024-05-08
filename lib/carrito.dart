import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'producto_carrito.dart';
import 'carritoModel.dart';

class Carrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ProductoCarrito> productosCarrito =
        Provider.of<CarritoModel>(context).productos;

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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${productosCarrito[index].cantidad}'),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          Provider.of<CarritoModel>(context, listen: false)
                              .eliminarProducto(productosCarrito[index]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
