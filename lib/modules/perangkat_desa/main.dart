import 'package:flutter/material.dart';
import 'pages/beranda.dart';
import 'pages/data.dart';
import 'pages/berita.dart';
import 'pages/akun.dart';
import 'pages/data/users/index.dart';
import 'pages/data/services/index.dart';

class PerangkatDesaMain extends StatefulWidget {
  const PerangkatDesaMain({super.key});

  @override
  State<PerangkatDesaMain> createState() => _PerangkatDesaMainState();
}

class _PerangkatDesaMainState extends State<PerangkatDesaMain> {
  int _selectedIndex = 0;
  bool _showUsersPage = false;
  bool _showServicesPage = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showServicesPage = false;
    });
  }

  void _openUsersPage() {
    setState(() {
      _showUsersPage = true;
    });
  }

  void _openServicesPage() {
    setState(() {
      _showServicesPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const BerandaPage(),
      DataMasterPage(
        onOpenUsers: _openUsersPage,
        onOpenServices: _openServicesPage,
      ),
      const BeritaPage(),
      const AkunPage(),
    ];

    return Scaffold(
      body: _showUsersPage
        ? UsersIndexPage(
            onBack: () {
              setState(() {
                _showUsersPage = false;
              });
            },
          )
        : _showServicesPage
            ? ServicesIndexPage(
                onBack: () {
                  setState(() {
                    _showServicesPage = false;
                  });
                },
              )
            : pages[_selectedIndex],

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
