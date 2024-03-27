// Imports the Flutter Material Design library, which provides a wide range of widgets and tools for building the UI.
import 'package:flutter/material.dart';
// Imports the shared_preferences package, which allows you to store simple data in key-value pairs.
import 'package:shared_preferences/shared_preferences.dart';

// Defines a StatefulWidget named CounterPage. This widget can maintain state that might change during the lifetime of the widget.
class CounterPage extends StatefulWidget {
  // The constructor for CounterPage takes an optional key parameter, which is passed to the superclass constructor.
  const CounterPage({super.key});

  // Overrides the createState method to return an instance of _CounterPageState. This is where the mutable state for this widget is held.
  @override
  State<CounterPage> createState() => _CounterPageState();
}

// Defines the state for CounterPage. This class holds the mutable state for the CounterPage widget.
class _CounterPageState extends State<CounterPage> {
  // SECTION variable
  int _count = 0;

  // SECTION method
  // Overrides the initState method, which is called once when the state is created.
  @override
  void initState() {
    // Calls the superclass's initState method to ensure that any initialization in the superclass is performed.
    super.initState();
    _loadCounter(); // loads the counter value from shared preferences
  }

  // Defines an asynchronous method _loadCounter to load the counter value from shared preferences.
  void _loadCounter() async {
    // Retrieves an instance of SharedPreferences.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Calls setState to update the UI with the loaded counter value if not sets it to 0
    setState(() => _count = (prefs.getInt('counter') ?? 0));
  }

  void increment() async {
    // Retrieves an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _count = (prefs.getInt('counter') ?? 0) + 1);
    // Saves the updated counter value to shared preferences.
    await prefs.setInt('counter', _count);
  }
  // void increment() {
  //   setState(() => _count += 1);
  // }

  void decrement() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() => _count = (prefs.getInt('counter') ?? 0) - 1);
    await prefs.setInt('counter', _count);
  }
  // void decrement() {
  //   setState(() => _count -= 1);
  // }

  // SECTION ui
  // Overrides the build method to describe the part of the user interface represented by this widget.
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
