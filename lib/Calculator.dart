import 'dart:convert';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_calculator/ConverterFolder/firedatabase/FbManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'history/historyScreen.dart';
import 'history/FirebaseData.dart';

import 'ConverterFolder/Converter.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  var io = "";
  var firstNumber = "";
  var oprator = "";
  var secondNumber = "";
  String history = "";
  List<String> historyList = [];
  String displayData = '';

  // Calculator Function//

  void calculator() {
    if (oprator == "+")
      setState(() {
        io =
            (double.parse(firstNumber) + double.parse(secondNumber)).toString();
      });
    else if (oprator == "-")
      setState(() {
        io =
            (double.parse(firstNumber) - double.parse(secondNumber)).toString();
      });
    else if (oprator == "X")
      setState(() {
        io =
            (double.parse(firstNumber) * double.parse(secondNumber)).toString();
      });
    else if (oprator == "/")
      setState(() {
        io =
            (double.parse(firstNumber) / double.parse(secondNumber)).toString();
      });
    else if (oprator == "%")
      setState(() {
        io =
            (double.parse(firstNumber) % double.parse(secondNumber)).toString();
      });
    else if (oprator == "^")
      setState(() {
        io = pow(double.parse(firstNumber), double.parse(secondNumber))
            .toString();
      });
    if (io.length > 10)
      setState(() {
        io = io.substring(0, 10);
      });
  }

// Controller

  void _controller(key) async {
    history = "";
    if (key == "=")
      calculator();
    else if (key == "AC")
      setState(() {
        io = "";
        firstNumber = "";
        oprator = "";
        secondNumber = "";
      });
    else if (key == "C") {
      if (oprator != "" && io == "")
        setState(() {
          oprator = "";
          io = firstNumber;
          firstNumber = "";
        });
      else
        setState(() {
          io = io.substring(0, io.length - 1);
          secondNumber = secondNumber.substring(0, secondNumber.length - 1);
        });
    } else if (["+", "-", "X", "/", "%", "^"].indexOf(key) >= 0) {
      if (secondNumber != "")
        setState(() {
          firstNumber = io;
          io = "";
          oprator = key;
          secondNumber = "";
        });
      else
        setState(() {
          firstNumber = io;
          io = "";
          oprator = key;
        });
    } else {
      if (oprator != "")
        setState(() {
          io = io + key;
          secondNumber = secondNumber + key;
        });
      else
        setState(() {
          io = io + key;
        });
     }

    // history Track

    setState(() {
      if (key == "=") {
        history = firstNumber.toString() +
            " " +
            oprator.toString() +
            " " +
            secondNumber.toString() +
            "   $io";
      }
    });

    historyList.add(history);
    await FbManager().createHistoryData(history);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('history', historyList);
  }

  Widget _button(String key, String type) {
    if (type == "input")
      return MaterialButton(
        height: 90.0,
        child: Text(key,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
        textColor: Colors.black,
        color: Colors.grey,
        onPressed: () => _controller(key),
      );
    else if (type == "operator")
      return MaterialButton(
        height: 90.0,
        child: Text(key,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
        textColor: Colors.black,
        color: Colors.blueAccent,
        onPressed: () => _controller(key),
      );

    return MaterialButton(
      height: 90.0,
      child: Text(key,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.black,
      color: Colors.white,
      onPressed: () => _controller(key),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //defines the content of the Appbar
        // ignore: prefer_const_constructors
        title: Text(
          "Calculator",
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),

        backgroundColor: Colors.black,
      ),

      //Drawer//

      drawer: Drawer(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(50.0)),
            ListTile(
              tileColor: Colors.lightBlue,
              title: Text('Converter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Converter()),
                );
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            ListTile(
              tileColor: Colors.lightBlue,
              title: Text('History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                );
              },
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            ListTile(
              tileColor: Colors.lightBlue,
              title: Text('Firebase History',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirebaseData()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        //defines the content of the body
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          verticalDirection: VerticalDirection.down, // exp
          textBaseline: TextBaseline.alphabetic, // exp
          crossAxisAlignment: CrossAxisAlignment.baseline, // exp
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " $firstNumber $oprator $secondNumber \t\t",
                  style: TextStyle(color: Colors.white70, fontSize: 30.0),
                  textAlign: TextAlign.right,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  " $io \t",
                  style: TextStyle(color: Colors.white, fontSize: 50.0),
                  textAlign: TextAlign.right,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("%", "operator"),
                _button("^", "operator"),
                _button("C", "operator"),
                _button("AC", "output")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("7", "input"),
                _button("8", "input"),
                _button("9", "input"),
                _button("/", "operator")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("4", "input"),
                _button("5", "input"),
                _button("6", "input"),
                _button("X", "operator")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("1", "input"),
                _button("2", "input"),
                _button("3", "input"),
                _button("+", "operator")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _button("=", "output"),
                _button("0", "input"),
                _button(".", "input"),
                _button("-", "operator"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
