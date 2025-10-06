import 'package:flutter/material.dart';
import 'pages/beranda.dart';
import 'pages/data.dart';
import 'pages/berita.dart';
import 'pages/akun.dart';

class PerangkatDesaMain extends StatefulWidget {
  const PerangkatDesaMain({super.key});

  @override
  State<PerangkatDesaMain> createState() => _PerangkatDesaMainState();
}

class _PerangkatDesaMainState extends State<PerangkatDesaMain> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    BerandaPage(),
    DataMasterPage(),
    BeritaPage(),
    AkunPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 36, 91, 202),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder_rounded),
            label: 'Data Master',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article_rounded),
            label: 'Berita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Akun',
          ),
        ],
      ),
    );
  }
}
