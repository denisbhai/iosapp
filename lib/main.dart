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
//
// // class PaginationExample extends StatefulWidget {
// //   @override
// //   _PaginationExampleState createState() => _PaginationExampleState();
// // }
// //
// // class _PaginationExampleState extends State<PaginationExample> {
// //   final int itemsPerPage = 10;
// //   int currentPage = 0;
// //
// //   late List<int> items;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     // Generate 66 items (1 to 66)
// //     items = List.generate(66, (index) => index + 1);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     int startIndex = currentPage * itemsPerPage;
// //     int endIndex = (startIndex + itemsPerPage);
// //     if (endIndex > items.length) {
// //       endIndex = items.length;
// //       log('message===$endIndex===${items.length}');
// //     }
// //
// //     List<int> paginatedItems = items.sublist(startIndex, endIndex);
// //
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Pagination Example")),
// //       body: Column(
// //         children: [
// //           // Item List
// //           Expanded(
// //             child: ListView.builder(
// //               itemCount: paginatedItems.length,
// //               itemBuilder: (context, index) {
// //                 return ListTile(
// //                   title: Text("Item ${paginatedItems[index]}"),
// //                 );
// //               },
// //             ),
// //           ),
// //
// //           // Pagination Buttons
// //           Padding(
// //             padding: const EdgeInsets.all(12.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 ElevatedButton(
// //                   onPressed: currentPage > 0
// //                       ? () {
// //                     setState(() {
// //                       currentPage--;
// //                     });
// //                   }
// //                       : null,
// //                   child: Text("Previous"),
// //                 ),
// //                 Text(
// //                   "Page ${currentPage + 1} / ${(items.length / itemsPerPage).ceil()}",
// //                   style: TextStyle(fontWeight: FontWeight.bold),
// //                 ),
// //                 ElevatedButton(
// //                   onPressed: endIndex < items.length
// //                       ? () {
// //                     setState(() {
// //                       currentPage++;
// //                     });
// //                   }
// //                       : null,
// //                   child: Text("Next"),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
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

      // body: LayoutBuilder(
      //   builder: (context, constraints) {
      //     // Decide number of columns based on width
      //     int crossAxisCount = 2; // default for mobile
      //     if (constraints.maxWidth > 1200) {
      //       crossAxisCount = 6; // desktop large screen
      //     } else if (constraints.maxWidth > 800) {
      //       crossAxisCount = 4; // tablet or web medium screen
      //     } else if (constraints.maxWidth > 500) {
      //       crossAxisCount = 3; // large phone
      //     }
      //
      //     return GridView.builder(
      //       padding: const EdgeInsets.all(10),
      //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: crossAxisCount,
      //         crossAxisSpacing: 10,
      //         mainAxisSpacing: 10,
      //         childAspectRatio: 1,
      //       ),
      //       itemCount: 10,
      //       itemBuilder: (context, index) {
      //         return Container(
      //           alignment: Alignment.center,
      //           decoration: BoxDecoration(
      //             color: Colors.blue[(index % 9 + 1) * 100],
      //             borderRadius: BorderRadius.circular(12),
      //           ),
      //           child: Text(
      //             "Item $index",
      //             style: const TextStyle(color: Colors.white, fontSize: 16),
      //           ),
      //         );
      //       },
      //     );
      //   },
      // ),
    );
  }
}

// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyScrollBehavior extends MaterialScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//     PointerDeviceKind.touch,
//     PointerDeviceKind.mouse,
//     PointerDeviceKind.stylus,
//   };
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Web / Desktop UX Demo',
//       debugShowCheckedModeBanner: false,
//       scrollBehavior: MyScrollBehavior(), // apply custom scroll behavior app-wide
//       home: const HomePage(),
//       shortcuts:  <LogicalKeySet, Intent>{
//         // Global shortcut: Ctrl/Cmd + K => Open search
//         LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK):
//         OpenSearchIntent(),
//         LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyK):
//         OpenSearchIntent(),
//       },
//       actions: <Type, Action<Intent>>{
//         OpenSearchIntent: CallbackAction<OpenSearchIntent>(
//           onInvoke: (intent) {
//             // handled in HomePage via FocusScope or similar; we'll leave a no-op here
//             return null;
//           },
//         ),
//       },
//     );
//   }
// }
//
// class OpenSearchIntent extends Intent {
//   const OpenSearchIntent();
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//   GlobalKey<ScaffoldMessengerState>();
//
//   void _showSnack(String text) {
//     _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
//     _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(content: Text(text)));
//   }
//
//   Future<void> _openSearchDialog() async {
//     final result = await showDialog<String>(
//       context: context,
//       builder: (ctx) {
//         return AlertDialog(
//           title: const Text('Search'),
//           content: TextField(
//             autofocus: true,
//             decoration: const InputDecoration(hintText: 'Type to search...'),
//             onSubmitted: (value) => Navigator.of(ctx).pop(value),
//           ),
//           actions: [
//             TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close')),
//           ],
//         );
//       },
//     );
//
//     if (result != null && result.isNotEmpty) {
//       _showSnack('Searched for: $result');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Listen for keyboard shortcuts at widget level (better than noop in MaterialApp)
//     // This approach captures the OpenSearchIntent and opens the dialog.
//     // We add a short delay to ensure context is available.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final actions = Actions.maybeFind(context);
//       // We'll wrap an Actions widget in build below for safe handling.
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Wrap with Shortcuts/Actions to open search
//     return Shortcuts(
//       shortcuts:  <LogicalKeySet, Intent>{
//         LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK):
//         OpenSearchIntent(),
//         LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyK):
//         OpenSearchIntent(),
//       },
//       child: Actions(
//         actions: <Type, Action<Intent>>{
//           OpenSearchIntent: CallbackAction<OpenSearchIntent>(onInvoke: (intent) {
//             _openSearchDialog();
//             return null;
//           }),
//         },
//         child: ScaffoldMessenger(
//           key: _scaffoldMessengerKey,
//           child: Scaffold(
//             appBar: AppBar(
//               title: const Text('Flutter Web / Desktop UX Demo'),
//               actions: [
//                 Tooltip(message: 'Open search (Ctrl/Cmd+K)', child: IconButton(icon: const Icon(Icons.search), onPressed: _openSearchDialog)),
//               ],
//             ),
//             body: LayoutBuilder(
//               builder: (context, constraints) {
//                 // simple responsive columns:
//                 final width = constraints.maxWidth;
//                 final crossAxisCount = width >= 1200
//                     ? 4
//                     : width >= 900
//                     ? 3
//                     : width >= 600
//                     ? 2
//                     : 1;
//
//                 return Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     children: [
//                       // Example of a toolbar that shows mouse cursor change
//                       Row(
//                         children: [
//                           Tooltip(
//                             message: 'Primary action',
//                             child: MouseRegion(
//                               cursor: SystemMouseCursors.click,
//                               child: ElevatedButton.icon(
//                                 onPressed: () => _showSnack('Primary clicked'),
//                                 icon: const Icon(Icons.add),
//                                 label: const Text('Primary'),
//                                 style: ElevatedButton.styleFrom(),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           MouseRegion(
//                             cursor: SystemMouseCursors.basic,
//                             child: OutlinedButton(
//                               onPressed: () => _showSnack('Outlined clicked'),
//                               child: const Text('Another'),
//                             ),
//                           ),
//                           const Spacer(),
//                           const Text('Window width:'),
//                           const SizedBox(width: 6),
//                           Text('${width.toStringAsFixed(0)} px'),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//
//                       // The grid area (scrollable)
//                       Expanded(
//                         child: ScrollConfiguration(
//                           behavior: MyScrollBehavior(),
//                           child: GridView.builder(
//                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: crossAxisCount,
//                               crossAxisSpacing: 12,
//                               mainAxisSpacing: 12,
//                               childAspectRatio: 1.2,
//                             ),
//                             itemCount: 20,
//                             itemBuilder: (context, index) {
//                               return _HoverCard(
//                                 index: index,
//                                 onPrimary: () => _showSnack('Clicked item $index'),
//                                 onSecondary: (details) {
//                                   // Right click handler
//                                   _showSnack('Right-clicked item $index at ${details.localPosition}');
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// A card that reacts to hover, shows pointer cursor, and handles right-click.
// class _HoverCard extends StatefulWidget {
//   final int index;
//   final VoidCallback onPrimary;
//   final void Function(PointerDownEvent) onSecondary;
//
//   const _HoverCard({
//     required this.index,
//     required this.onPrimary,
//     required this.onSecondary,
//     super.key,
//   });
//
//   @override
//   State<_HoverCard> createState() => _HoverCardState();
// }
//
// class _HoverCardState extends State<_HoverCard> {
//   bool _hover = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Listener(
//       onPointerDown: (PointerDownEvent event) {
//         // Detect right click (secondary button) and forward to handler.
//         if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
//           widget.onSecondary(event);
//         }
//       },
//       child: MouseRegion(
//         onEnter: (_) => setState(() => _hover = true),
//         onExit: (_) => setState(() => _hover = false),
//         cursor: SystemMouseCursors.click,
//         child: GestureDetector(
//           onTap: widget.onPrimary,
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 180),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: _hover ? Colors.blue.shade50 : Colors.white,
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade300),
//               boxShadow: _hover
//                   ? [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 )
//               ]
//                   : null,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Center(child: Text('Thumb ${widget.index}')),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Text('Item ${widget.index}', style: Theme.of(context).textTheme.titleSmall),
//                 const SizedBox(height: 4),
//                 const SelectableText('Description is selectable and copyable.'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => NavigationProvider(),
//       child: MyApp(),
//     ),
//   );
// }
//
// class NavigationProvider extends ChangeNotifier {
//   int _currentIndex = 0;
//   int get currentIndex => _currentIndex;
//
//   void setIndex(int index) {
//     _currentIndex = index;
//     notifyListeners();
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'BottomNav + Drawer Example',
//       initialRoute: '/',
//       onGenerateRoute: (settings) {
//         // Handle routes that should be shown without bottom navigation
//         switch (settings.name) {
//           case '/logout':
//             return MaterialPageRoute(builder: (_) => LogoutPage());
//           case '/demo':
//             return MaterialPageRoute(builder: (_) => DemoPage());
//           default:
//             return MaterialPageRoute(builder: (_) => MainScreen());
//         }
//       },
//       routes: {
//         '/': (context) => MainScreen(),
//       },
//     );
//   }
// }
//
// class MainScreen extends StatelessWidget {
//   final List<GlobalKey<NavigatorState>> _navigatorKeys = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final navProvider = Provider.of<NavigationProvider>(context);
//
//     return Scaffold(
//       body: IndexedStack(
//         index: navProvider.currentIndex,
//         children: [
//           _buildNavigator(_navigatorKeys[0], HomeScreen()),
//           _buildNavigator(_navigatorKeys[1], SearchScreen()),
//           _buildNavigator(_navigatorKeys[2], ProfileScreen()),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: navProvider.currentIndex > 2 ? 0 : navProvider.currentIndex,
//         onTap: (index) {
//           navProvider.setIndex(index);
//           _navigatorKeys[index].currentState!.popUntil((route) => route.isFirst);
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavigator(GlobalKey<NavigatorState> key, Widget screen) {
//     return Navigator(
//       key: key,
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/detail':
//             return MaterialPageRoute(builder: (_) => DetailPage());
//           case '/privacy': // Add privacy policy route to nested navigator
//             return MaterialPageRoute(builder: (_) => PrivacyPolicyPage());
//           default:
//             return MaterialPageRoute(builder: (_) => screen);
//         }
//       },
//     );
//   }
// }
//
// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("BottomNav + Drawer Example")),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//             const DrawerHeader(
//               child: Text("Menu", style: TextStyle(fontSize: 18)),
//             ),
//             ListTile(
//               title: const Text("Privacy Policy"),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.of(context).pushNamed('/privacy');
//               },
//             ),
//             ListTile(
//               title: const Text("Logout"),
//               onTap: () {
//                 Navigator.pop(context);
//                 // Use root navigator for replacement (this will hide bottom nav)
//                 Navigator.of(context, rootNavigator: true).pushReplacementNamed('/logout');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text("Open Detail Page"),
//           onPressed: () {
//             // Use the current navigator (with bottom nav)
//             Navigator.of(context).pushNamed('/detail');
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class SearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Text("Search Screen")));
//   }
// }
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Center(child: Text("Profile Screen")));
//   }
// }
//
// class DetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Detail Page")),
//       body: Center(
//         child: ElevatedButton(
//           child: Text("DemoPage Open"),
//           onPressed: () {
//             // Use root navigator for full-screen pages (no bottom nav)
//             Navigator.of(context, rootNavigator: true).pushNamed('/demo');
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class DemoPage extends StatelessWidget {
//   const DemoPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Demo Page")),
//       body: Center(child: Text("This is the Demo page (no bottom nav)")),
//     );
//   }
// }
//
// class PrivacyPolicyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Privacy Policy"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: const Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Text(
//             "Privacy Policy Content Here\n\nThis page shows with bottom navigation because it's part of the tab navigator.",
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LogoutPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Logout")),
//       body: Center(
//         child: Text("You are logged out", style: TextStyle(fontSize: 20)),
//       ),
//     );
//   }
// }