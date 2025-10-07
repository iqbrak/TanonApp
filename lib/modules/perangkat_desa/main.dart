import 'package:flutter/material.dart';
import 'pages/beranda.dart';
import 'pages/data.dart';
import 'pages/berita.dart';
import 'pages/akun.dart';
import 'pages/data/users/index.dart';
import 'pages/data/services/index.dart';
import 'pages/berita_detail.dart';

class PerangkatDesaMain extends StatefulWidget {
  const PerangkatDesaMain({super.key});

  @override
  State<PerangkatDesaMain> createState() => _PerangkatDesaMainState();
}

class _PerangkatDesaMainState extends State<PerangkatDesaMain> {
  int _selectedIndex = 0;
  bool _showUsersPage = false;
  bool _showServicesPage = false;
  bool _showDetailPage = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _showUsersPage = false;
      _showServicesPage = false;
      _showDetailPage = false;
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

  void _openDetailPage() {
    setState(() {
      _showDetailPage = true;
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
      BeritaPage(
        onOpenDetail: _openDetailPage,
      ),
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
              : _showDetailPage
                  ? BeritaDetailPage(
                      onBack: () {
                        setState(() {
                          _showDetailPage = false;
                        });
                      },
                      title: "Judul Berita Contoh",
                      image: "assets/images/berita.png",
                      tanggal: "06 Okt 2025",
                      isi:
                          '''
                            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur in purus non magna gravida tincidunt. Proin lacinia, lectus nec pulvinar convallis, velit sapien dapibus justo, vel posuere mauris nunc at sapien. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Cras interdum est ac tellus suscipit, vel dictum elit ultricies. 
                            
                            Suspendisse potenti. Integer a eros nec est gravida finibus. Maecenas tincidunt, justo sit amet facilisis elementum, turpis justo interdum sapien, ac volutpat est felis et turpis. Sed a arcu felis. Nullam vehicula consequat urna, vitae elementum risus mattis sit amet. Etiam in tortor non lacus tincidunt accumsan. 

                            Aliquam non neque sed sem malesuada gravida. Donec ac fermentum risus. Phasellus at augue at mi ultrices tincidunt. Aenean pharetra libero nec suscipit cursus. Suspendisse iaculis orci vel eros pulvinar, vitae faucibus lorem convallis. Vivamus in metus ac mi vulputate gravida nec ac massa. 

                            Mauris ut dolor vel sapien euismod luctus sit amet eget augue. Vestibulum vitae magna ut erat volutpat interdum. Donec ut dolor a lectus rhoncus efficitur. In hac habitasse platea dictumst. Phasellus et tellus ac odio bibendum vehicula non ut massa.
                            '''
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
