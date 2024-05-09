import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'carritoModel.dart';
import 'producto_carrito.dart';
import 'producto.dart';

class ChaquetasPage extends StatefulWidget {
  @override
  _ChaquetasState createState() => _ChaquetasState();
}

class _ChaquetasState extends State<ChaquetasPage> with SingleTickerProviderStateMixin {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Producto> productos = [];
  late AnimationController _controller;
  Set<int> addedProducts = {};

  @override
  void initState() {
    super.initState();
    fetchChaquetas();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
  }

  fetchChaquetas() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('Productos')
          .where('categoria', isEqualTo: 'chaquetas')
          .get();
      List<Producto> productos =
          snapshot.docs.map((doc) => Producto.fromFirestore(doc)).toList();
      setState(() {
        this.productos = productos;
      });

      for (var producto in productos) {
        for (var url in producto.imagen) {
          print('URL de la imagen: $url');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chaquetas'),
      ),
      body: productos.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: productos[index].imagen[0],
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  title: Text(productos[index].nombre),
                  subtitle: Text(productos[index].categoria),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\$${productos[index].precio.toStringAsFixed(2)}'),
                      IconButton(
                        icon: AnimatedCrossFade(
                          duration: const Duration(seconds: 1),
                          firstChild: Icon(Icons.add_shopping_cart),
                          secondChild: Icon(Icons.shopping_cart),
                          crossFadeState: addedProducts.contains(index) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        ),
                        onPressed: () {
                          Provider.of<CarritoModel>(context, listen: false)
                              .agregarProducto(
                            ProductoCarrito(
                              ProductoC.fromProducto(productos[index]),
                              1,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Producto añadido al carrito'),
                            ),
                          );
                          setState(() {
                            addedProducts.add(index);
                          });
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