import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

const moradito = Color.fromRGBO(208, 158, 255, 1);
var cyanGrid = Colors.cyan[100];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Meow',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      home: MyHomePage(title: 'Tic Tac Meow'),
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

  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: moradito,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            ButtonTheme(
              minWidth: 200,
              height: 80,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: moradito, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage(widget.title)
                    )
                  );
                },
                child: Text(
                  "New game!",
                  style: TextStyle(
                    fontSize: 25,
                    color: moradito,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Spacer(),
            ButtonTheme(
              minWidth: 100,
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: moradito, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoPage(widget.title)
                      )
                  );
                },
                child: Text(
                  "Credits",
                  style: TextStyle(
                    fontSize: 15,
                    color: moradito,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {

  final String title;

  GamePage(this.title);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {

  var marks = new List(9);
  var turns = [Icons.clear, Icons.trip_origin, Icons.clear, Icons.trip_origin, Icons.clear, Icons.trip_origin, Icons.clear, Icons.trip_origin, Icons.clear];
  var turnCounter = 0;
  var winnerMark;
  var winner = false;
  var hasWon = "";

  placeMark(i){
    if (!winner && marks[i] == null) {
      setState(() {
        turnCounter = turnCounter == 8 ? 0 : turnCounter;
        marks[i] = turnCounter.isEven ? Icons.clear : Icons.trip_origin;

        turnCounter++;
      });
      checkWin();
    }
  }

  var winCombos = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],//horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8],//vertical
    [0, 4, 8], [2, 4, 6]//diagonal
  ];

  checkWin(){
    var x = Icons.clear, o = Icons.trip_origin;

    for(int i = 0; i <=7; i++){//Check for X winning
      if (marks[winCombos[i][0]] == x && marks[winCombos[i][1]] == x && marks[winCombos[i][2]] == x){
        winnerMark = x;
        winner = true;
      }
    }

    for(int i = 0; i <=7; i++){//Check for O winning
      if (marks[winCombos[i][0]] == o && marks[winCombos[i][1]] == o && marks[winCombos[i][2]] == o){
        winnerMark = o;
        winner = true;
      }
    }

    if (winner){
      hasWon = "WINNER";
      _controllerCenter.play();
    }
  }

  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
  }

  restartGame(){
    setState(() {
      marks = new List(9);
      turnCounter = 0;
      hasWon = "";
      winner = false;
      winnerMark = null;
      _controllerCenter.stop();
    });
  }

  ConfettiController _controllerCenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: moradito,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Spacer(),
                Text(
                    "You are playing as: ",
                    style: TextStyle(fontSize: 18,
                      color: moradito,
                      fontWeight: FontWeight.w200,
                  ),
                ),
                Icon(
                  turns[turnCounter],
                  color: moradito,
                  size: 40,
                ),
                Spacer(),
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(0);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.cyan[100],
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[0],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[1],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(2);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[2],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(3);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[3],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(4);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[4],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(5);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[5],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(6);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[6],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(7);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[7],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {
                  placeMark(8);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: cyanGrid,
                  ),
                  margin: EdgeInsets.all(5),
                  width: 100,
                  height: 100,
                  child: Icon(
                    marks[8],
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                hasWon,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.purple,
                  fontWeight: FontWeight.w900
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Icon(
                    winnerMark,
                    color: Colors.purple,
                    size: 100,
                  ),
                  ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: true,
                    maximumSize: Size(20, 20),
                    minimumSize: Size(5, 5),
                    maxBlastForce: 10,
                    numberOfParticles: 30,
                    colors: [
                      Colors.purple[200],
                      Colors.cyan[200],
                      Colors.yellow[200],
                    ],
                  ),
                ],
              ),
              FloatingActionButton(
                backgroundColor: moradito,
                child: Icon(
                    Icons.autorenew,
                    color: Colors.white,
                  ),
                onPressed: (){
                  restartGame();
                },
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class InfoPage extends StatelessWidget {

  final String title;

  InfoPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: moradito,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Image.asset(
              'playstore.png',
              height: 150,
              width: 150,
            ),
            Spacer(),
            Text(
              "This a demo app built with Flutter",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Built by mnchava",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "github.com/mnchava",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Using confetti package by funwith.app",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

}