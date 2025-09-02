import 'dart:developer';
import 'package:flutter/material.dart';

/////////////////=============////////////////////
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


void main() => runApp(MaterialApp(home: MyList()));

class MyList extends StatefulWidget {
  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  List<String> items = ["Apple", "Banana", "Cherry"];

  String name = "Denis is";

  @override
  Widget build(BuildContext context) {
    log("====name====${name.split(" ").join()}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Without Key"),
        actions: [
          RepaintBoundary(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.yellow,
              child: Text("I won’t repaint unless I change!"),
            ),
          ),
          RepaintBoundary(
            child: Container(
              width: 200,
              height: 200,
              color: Colors.yellow,
              child: Text("I won’t repaint unless I change!"),
            ),
          ),
        ],
      ),
      body: ListView(
        children: items
            .map((item) => CounterWidget(item, key: ValueKey(item)))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.swap_vert),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CounterWidget("demo")),
          );
          setState(() {
            items.insert(0, items.removeAt(2)); // Swap Cherry to top
          });
        },
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final String name;
  CounterWidget(this.name, {Key? key}) : super(key: key);

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${widget.name} (count: $counter)"),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => setState(() => counter++),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// void main() => runApp(MaterialApp(home: UniqueKeyDemo()));
//
// class UniqueKeyDemo extends StatefulWidget {
//   @override
//   State<UniqueKeyDemo> createState() => _UniqueKeyDemoState();
// }
//
// class _UniqueKeyDemoState extends State<UniqueKeyDemo> {
//   bool toggle = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("UniqueKey Example")),
//       body: Center(
//         child: toggle
//             ? CounterWidget(key: UniqueKey()) // ✅ Unique every time
//             : CounterWidget(key: UniqueKey()), // ✅ Unique every time
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.refresh),
//         onPressed: () {
//           setState(() {
//             toggle = !toggle; // swap widget
//           });
//         },
//       ),
//     );
//   }
// }
//
// class CounterWidget extends StatefulWidget {
//   CounterWidget({Key? key}) : super(key: key);
//
//   @override
//   State<CounterWidget> createState() => _CounterWidgetState();
// }
//
// class _CounterWidgetState extends State<CounterWidget> {
//   int counter = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Counter: $counter", style: TextStyle(fontSize: 22)),
//         ElevatedButton(
//           child: Text("Increment"),
//           onPressed: () => setState(() => counter++),
//         ),
//       ],
//     );
//   }
// }
