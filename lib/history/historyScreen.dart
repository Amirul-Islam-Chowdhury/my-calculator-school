import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> historyLists = [];

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      historyLists = prefs.getStringList('history')!.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    display() {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: historyLists.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Column(children: [
                  SizedBox(
                    child: Text(
                      ' =>  ${historyLists[index]}',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ]));
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(" History"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: display());
  }
}
