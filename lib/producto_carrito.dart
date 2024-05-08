import 'producto.dart';

class ProductoC {
  String nombre;

  ProductoC.fromProducto(Producto producto) : nombre = producto.nombre;
}

class ProductoCarrito {
  ProductoC producto;
  int cantidad;

  ProductoCarrito(this.producto, this.cantidad);
}
