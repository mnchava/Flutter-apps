import 'package:flutter/material.dart';
import 'grafos.dart';
import 'constantes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grafos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Grafos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Nodo> nodos;
  List arcos;
  MatrizAdyacencia matriz;

  @override
  void initState() {
    super.initState();

    nodos = [
      Nodo(0, nombres[0], colores[0]),
      Nodo(1, nombres[1], colores[1]),
      Nodo(2, nombres[2], colores[2]),
      Nodo(3, nombres[3], colores[3]),
      Nodo(4, nombres[4], colores[4]),
      Nodo(5, nombres[5], colores[5]),
    ];
    arcos = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      body: Center(
        child: TablaMatriz(nodos, arcos),
      ),
    );
  }
}
