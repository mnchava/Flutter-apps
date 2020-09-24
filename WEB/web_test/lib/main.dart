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
        primarySwatch: Colors.amber,
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

  @override
  void initState() {
    super.initState();

    nodos = List.generate(6, (index) {
      return Nodo(nombres[index], colores[index]);
    });
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
