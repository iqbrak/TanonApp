import 'package:flutter/material.dart';
import 'modules/perangkat_desa/pd_main.dart';
import 'modules/perangkat_desa/pages/pd_beranda.dart';
import 'modules/perangkat_desa/pages/pd_data.dart';
import 'modules/perangkat_desa/pages/pd_berita.dart';
import 'modules/perangkat_desa/pages/pd_akun.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/pd':
        return MaterialPageRoute(builder: (_) => const PerangkatDesaMain());
      case '/pd/beranda':
        return MaterialPageRoute(builder: (_) => const DesaBerandaPage());
      case '/pd/data':
        return MaterialPageRoute(builder: (_) => const DesaDataPage());
      case '/pd/berita':
        return MaterialPageRoute(builder: (_) => const DesaBeritaPage());
      case '/pd/akun':
        return MaterialPageRoute(builder: (_) => const DesaAkunPage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Halaman tidak ditemukan')),
          ),
        );
    }
  }
}
