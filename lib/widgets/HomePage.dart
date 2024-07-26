import 'package:flutter/material.dart';
import 'package:repertorio/widgets/CustomAppBar.dart';

import 'MusicList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const _widgetOptions = <Widget>[
    MusicList(),
    Text('Repertório'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const CustomAppBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.music_note), label: 'Músicas'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: 'Repertório'),
        ],
        onTap: _onItemTapped,
        selectedItemColor: Color(Colors.deepOrange.value),
        currentIndex: _selectedIndex,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        onPressed: () {
          print("denis");
        },
        backgroundColor: Color(Colors.deepOrange.value),
        child: const Icon(Icons.add),
      )
    );
  }
}
