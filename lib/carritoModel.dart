import 'package:flutter/foundation.dart';
import 'producto_carrito.dart';

class CarritoModel extends ChangeNotifier {
  final List<ProductoCarrito> productos = [];

  void agregarProducto(ProductoCarrito producto) {
    productos.add(producto);
    notifyListeners();
  }

  void eliminarProducto(ProductoCarrito producto) {
    productos.remove(producto);
    notifyListeners();
  }
}
