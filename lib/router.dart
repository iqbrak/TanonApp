import 'package:go_router/go_router.dart';

import 'modules/perangkat_desa/pd_main.dart';

import 'modules/perangkat_desa/pages/pd_beranda.dart';
import 'modules/perangkat_desa/pages/pd_data.dart';
import 'modules/perangkat_desa/pages/pd_berita.dart';
import 'modules/perangkat_desa/pages/pd_akun.dart';

import 'modules/perangkat_desa/pages/data/users/pd_users.dart';
import 'modules/perangkat_desa/pages/data/users/pd_users_add.dart';
import 'modules/perangkat_desa/pages/data/users/pd_users_edit.dart';
import 'modules/perangkat_desa/pages/pd_data_services.dart';
import 'modules/perangkat_desa/pages/pd_data_news.dart';
import 'modules/perangkat_desa/pages/pd_data_requests.dart';
import 'modules/perangkat_desa/pages/pd_berita_detail.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/pd/beranda',
  routes: [
    ShellRoute(
      builder: (context, state, child) => PerangkatDesaMain(child: child),
      routes: [
        GoRoute(path: '/pd/beranda', builder: (_, __) => const DesaBerandaPage()),
        GoRoute(path: '/pd/data', builder: (_, __) => const DesaDataPage()),
        GoRoute(path: '/pd/berita', builder: (_, __) => const DesaBeritaPage()),
        GoRoute(path: '/pd/akun', builder: (_, __) => const DesaAkunPage()),

        GoRoute(path: '/pd/data/users', builder: (_, __) => const DesaDataUsersPage()),
        GoRoute(path: '/pd/data/users/add', builder: (_, __) => const DesaDataUsersAddPage()),
        GoRoute(path: '/pd/data/users/edit', builder: (_, __) => const DesaDataUsersEditPage()),
        GoRoute(path: '/pd/data/services', builder: (_, __) => const DesaDataServicesPage()),
        GoRoute(path: '/pd/data/news', builder: (_, __) => const DesaDataNewsPage()),
        GoRoute(path: '/pd/data/requests', builder: (_, __) => const DesaDataRequestsPage()),
        GoRoute(path: '/pd/berita/detail', builder: (_, __) => const DesaBeritaDetailPage()),
      ],
    ),
  ],
);
