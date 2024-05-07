class Producto {
  String nombre;

  Producto(this.nombre);
}

class ProductoCarrito {
  Producto producto;
  int cantidad;

  ProductoCarrito(this.producto, this.cantidad);
}