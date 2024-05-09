import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'producto_carrito.dart';
import 'carritoModel.dart';

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

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
          : AnimatedList(
              key: _listKey,
              initialItemCount: productosCarrito.length,
              itemBuilder: (context, index, animation) {
                return RotationTransition(
                  turns: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart),
                      title: Text(productosCarrito[index].producto.nombre),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${productosCarrito[index].cantidad}'),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              _listKey.currentState!.removeItem(
                                index,
                                (context, animation) => RotationTransition(
                                  turns: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: SizedBox.shrink(), // empty widget
                                  ),
                                ),
                              );
                              Provider.of<CarritoModel>(context, listen: false)
                                  .eliminarProducto(productosCarrito[index]);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}