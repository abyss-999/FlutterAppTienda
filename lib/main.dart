import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login_page.dart';
import 'tienda.dart';
import 'camiseta.dart';
import 'pantalones.dart';
import 'chaquetas.dart';
import 'tenis.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/camisas': (context) => CamisasPage(),
        '/chaquetas': (context) => ChaquetasPage(),
        '/pantalones': (context) => PantalonesPage(),
        '/tenis': (context) => TenisPage(),
      },
      home: LoginPage(),
    );
  }
}
