import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'constantes.dart';

// ignore: must_be_immutable
class Grafo extends StatefulWidget {
  List<Nodo> nodos;
  List<int> ids = [];
  List arcos;
  double width = 250;
  double height = 250;
  double centerX;
  double centerY;
  List<Coord> posicion;

  Grafo(this.nodos, {this.arcos}) {
    centerX = width / 2;
    centerY = height / 2;
    posicion = posiciones[nodos.length];
  }

  @override
  _GrafoState createState() => _GrafoState();
}

class _GrafoState extends State<Grafo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Stack(
            //arcos
            children: List.generate(widget.arcos.length, (index) {
              int nodoA = widget.arcos[index][0];
              int nodoB = widget.arcos[index][1];

              Coord inicioArco = Coord(
                  widget.centerX + widget.posicion[nodoA].x,
                  widget.centerY + widget.posicion[nodoA].y);
              Coord finArco = Coord(widget.centerX + widget.posicion[nodoB].x,
                  widget.centerY + widget.posicion[nodoB].y);

              return Arco(inicioArco, finArco);
            }),
          ),
          Stack(
            //nodos
            children: List.generate(
              widget.nodos.length,
              (index) {
                return Positioned(
                  left: widget.centerX + widget.posicion[index].x - 30,
                  top: widget.centerY + widget.posicion[index].y - 30,
                  child: widget.nodos[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset start, end;
  Color color;

  LinePainter(this.start, this.end, {this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) return;
    canvas.drawLine(
        start,
        end,
        Paint()
          ..strokeWidth = 5
          ..color = color);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return true;
  }
}

// ignore: must_be_immutable
class Nodo extends StatefulWidget {
  Color color;
  String nombre;

  Nodo(this.nombre, this.color);

  @override
  _NodoState createState() => _NodoState();
}

class _NodoState extends State<Nodo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: widget.color, width: 8),
          color: Colors.white),
      width: 60,
      height: 60,
      alignment: Alignment.center,
      padding: EdgeInsets.all(5),
      child: Text(
        widget.nombre,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Coord {
  double x;
  double y;

  Coord(this.x, this.y);
}

// ignore: must_be_immutable
class Arco extends StatefulWidget {
  Coord start, end;
  Offset inicio, fin;

  Arco(this.start, this.end) {
    inicio = Offset(start.x, start.y);
    fin = Offset(end.x, end.y);
  }

  @override
  _ArcoState createState() => _ArcoState();
}

class _ArcoState extends State<Arco> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(widget.inicio, widget.fin, color: Colors.black),
    );
  }
}

class MatrizAdyacencia {
  List<Nodo> nodos;
  List arcos;
  List matriz = [];
  int filas;

  MatrizAdyacencia(this.nodos, this.arcos) {
    for (var _ in nodos) {
      matriz.add(List.filled(nodos.length, 0));
    }

    for (var arco in arcos) {
      int a = arco[0], b = arco[1];

      matriz[a][b] = 1;
      matriz[b][a] = 1;
    }

    filas = nodos.length;
  }

  List getMatriz() => matriz;

  List getArcos() {
    List arcos = [];

    for (int i = 0; i < matriz.length; i++) {
      for (int j = 0; j < matriz[i].length; j++) {
        if (matriz[i][j] == 1) {
          arcos.add([i, j]);
        }
      }
    }

    return arcos;
  }

  void resetMatriz() {
    matriz.clear();
    for (var _ in nodos) {
      matriz.add(List.filled(nodos.length, 0));
    }
  }
}

// ignore: must_be_immutable
class TablaMatriz extends StatefulWidget {
  MatrizAdyacencia fuente;
  List<Nodo> nodos;
  List arcos;

  TablaMatriz(this.nodos, this.arcos) {
    fuente = MatrizAdyacencia(nodos, arcos);
  }

  @override
  _TablaMatrizState createState() => _TablaMatrizState();
}

class _TablaMatrizState extends State<TablaMatriz> {
  List elementos = [];
  List<Nodo> nodos = [];
  List arcos = [];
  int numNodos = 6;
  List<bool> seleccionados = List.generate(5, (index) {
    return index == 4;
  });

  @override
  void initState() {
    super.initState();

    nodos = widget.nodos;

    for (int j = 0; j < widget.fuente.matriz.length; j++) {
      for (int i = 0; i < widget.fuente.matriz[j].length; i++) {
        elementos.add(widget.fuente.matriz[j][i]);
      }
    }
  }

  SliverGridDelegate gridDelegate;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Matriz de Adyacencia',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
        //numero de nodos
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Número de nodos: '),
            Container(
              color: Colors.white,
              child: ToggleButtons(
                fillColor: Colors.white,
                selectedColor: Colors.black,
                children: List.generate(seleccionados.length, (index) {
                  return Text(
                    (index + 2).toString(),
                    style: TextStyle(
                      color: colores[index + 1],
                      fontWeight: seleccionados[index]
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: seleccionados[index] ? 23 : 13,
                    ),
                  );
                }),
                isSelected: seleccionados,
                onPressed: (index) {
                  setState(() {
                    seleccionados.fillRange(0, 5, false);
                    seleccionados[index] = true;
                    numNodos = index + 2;
                    elementos.fillRange(0, elementos.length - 1, 0);
                    nodos = widget.nodos.sublist(0, numNodos);
                    widget.fuente.nodos = nodos;
                    widget.fuente.resetMatriz();
                    arcos = widget.fuente.getArcos();
                  });
                },
              ),
            ),
          ],
        ),
        //tabla
        Text('Toca para agregar o quitar aristas'),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // nombres de nodo
            Container(
              height: 220,
              margin: EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: List.generate(
                  numNodos,
                  (index) {
                    return Text(
                      'Nodo ' + index.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    );
                  },
                ),
              ),
            ),
            //tabla
            Container(
              width: 220,
              height: 220,
              padding: EdgeInsets.all(5),
              color: Colors.white,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numNodos,
                ),
                itemCount: numNodos * numNodos,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber[100],
                      ),
                      margin: EdgeInsets.all(2),
                      alignment: Alignment.center,
                      child: Text(
                        elementos[index].toString(),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        if (elementos[index] == 0) {
                          elementos[index] = 1;
                          elementos[equivalente[numNodos][index]] = 1;
                          widget.fuente.matriz[(index ~/ numNodos)]
                              [index % numNodos] = 1;
                          widget.fuente.matriz[index % numNodos]
                              [(index ~/ numNodos)] = 1;
                        } else {
                          elementos[index] = 0;
                          elementos[equivalente[numNodos][index]] = 0;
                          widget.fuente.matriz[(index ~/ numNodos)]
                              [index % numNodos] = 0;
                          widget.fuente.matriz[index % numNodos]
                              [(index ~/ numNodos)] = 0;
                        }
                        arcos = widget.fuente.getArcos();
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
        Grafo(nodos, arcos: arcos),
        Container(
          height: 120,
          alignment: Alignment.center,
          child: RichText(
            softWrap: true,
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                    text: 'Práctica Grafos', style: TextStyle(fontSize: 30)),
                TextSpan(text: '\nInteligencia Artificial | 5ºM'),
                TextSpan(text: '\nJesus Salvador Uribe Ferrer'),
                TextSpan(text: '\n17110306'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
