import 'package:flutter/material.dart';

void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/profilepic.jpg'),
              ),
              Text(
                'Chava Ferrer',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico'
                ),
              ),
              Text(
                'APP DEVELOPER',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontFamily: 'Source Sans Pro',
                  letterSpacing: 2
                ),
              ),
              SizedBox(
                width: 200,
                height: 30,
                child: Divider(
                  color: Colors.teal.shade100
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      size: 40,
                      color: Colors.teal,
                    ),
                    title: Text(
                      '+52 33 1251 8819',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20
                      ),
                    )

                  )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                        leading: Icon(
                          Icons.email,
                          size: 40,
                          color: Colors.teal,
                        ),
                        title: Text(
                          'mnchava@outlook.com',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20
                          ),
                        )

                    )
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ListTile(
                        leading: Icon(
                          Icons.public,
                          size: 40,
                          color: Colors.teal,
                        ),
                        title: Text(
                          'chavaferrer.carrd.com',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 20
                          ),
                        )

                    )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
