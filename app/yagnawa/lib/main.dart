import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const IconButton(
            icon: Icon(Icons.menu),
            onPressed: null,
          ),
          title: const Text("약나와"),
          centerTitle: true,
          actions: const [
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: null
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: null
            ),
          ],
          backgroundColor: Colors.green,
        ),

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              title: Text("Favorites"),
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              title: Text("List"),
              icon: Icon(Icons.list),
            ),
          ],
        ),

        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      )
    );
  }

  final List _widgetOptions = [
    const Text(
      "Favorites",
      style: TextStyle(
        fontSize: 30,
        fontFamily: "DoHyeonRegular",
      )
    ),
    const Text(
      "List",
      style: TextStyle(
        fontSize: 30,
        fontFamily: "DoHyeonRegular",
      )
    ),
  ];
}