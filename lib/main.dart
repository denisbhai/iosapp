import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pagination Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MovingColorGrid(),
    );
  }
}

class MovingColorGrid extends StatefulWidget {
  const MovingColorGrid({super.key});

  @override
  State<MovingColorGrid> createState() => _MovingColorGridState();
}

class _MovingColorGridState extends State<MovingColorGrid> {
  int startIndex = 0; // moving window index
  final int totalItems = 20;

  final colors = [Colors.green, Colors.yellow, Colors.red];

  @override
  void initState() {
    super.initState();

    // Timer to move colors every 500ms
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        startIndex = (startIndex + 1) % totalItems;
        log("startIndex===$startIndex====");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Moving Colors Grid")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: totalItems,
        itemBuilder: (context, index) {
          int relativeIndex = (index - startIndex + totalItems) % totalItems;
          log('index=$relativeIndex ===$index==$startIndex==$totalItems===${(index - startIndex + totalItems) % totalItems}');

          Color color = Colors.transparent;
          if (relativeIndex >= 0 && relativeIndex < 3) {
            color = colors[relativeIndex];
            log('relativeIndex==$relativeIndex');
          }

          // final color = colors[index % colors.length]; // loop 3 colors

          return Container(
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: Colors.black12),
            ),
            child: Center(
              child: Text(
                "${index + 1}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
