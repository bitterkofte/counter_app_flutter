import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
   // SECTION variable
  int _count = 0;

  // SECTION method
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = (prefs.getInt('counter') ?? 0);
    });
  }

  void increment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = (prefs.getInt('counter') ?? 0) + 1;
    });
    await prefs.setInt('counter', _count);
  }
  // void increment() {
  //   setState(() => _count += 1);
  // }

  void decrement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = (prefs.getInt('counter') ?? 0) - 1;
    });
    await prefs.setInt('counter', _count);w
  }
  // void decrement() {
  //   setState(() => _count -= 1);
  // }

  // SECTION ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$_count",
                style: TextStyle(
                    color: Colors.blue[700],
                    fontSize: 30,
                    fontWeight: FontWeight.w900)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: decrement,
                    child:
                        Icon(Icons.remove_circle_outline, color: Colors.red)),
                ElevatedButton(
                    onPressed: increment,
                    child: Icon(Icons.add_circle_outline, color: Colors.green)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
