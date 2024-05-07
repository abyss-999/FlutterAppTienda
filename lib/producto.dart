class Producto {
  final String nombre;
  final String categoria;
  final double precio;
  final List<String> imagen;

  Producto({
    this.nombre = '',
    this.categoria = '',
    this.precio = 0.0,
    this.imagen = const [],
  });
}