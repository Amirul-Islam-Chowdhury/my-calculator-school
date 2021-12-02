import 'package:flutter/material.dart';

class Converter extends StatefulWidget {
  @override
  _ConveterState createState() => _ConveterState();
}

class _ConveterState extends State<Converter> {
  double input1 = 0, result = 0;
  double mile = 0.621371;

  final TextEditingController t1 = TextEditingController(text: '');

  void doConvert() {
    setState(() {
      input1 = double.parse(t1.text);
      result = input1 * mile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(" Km to Mile Converter")),
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Enter  Kilometer here '),
                controller: t1,
              ),
              Padding(padding: const EdgeInsets.only(bottom: 20.0)),

              // add buttom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MaterialButton(
                      child: Text(" Convert"),
                      color: Colors.blueAccent,
                      onPressed: doConvert)
                ],
              ),

              Padding(padding: const EdgeInsets.only(bottom: 20.0)),

              Text(" Miles : $result",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ],
          ),
        ));
  }
}
