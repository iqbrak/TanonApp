import 'package:go_router/go_router.dart';
import 'core/controllers/auth_controller.dart';
import 'modules/auth/login.dart';
import 'modules/auth/register.dart';
import 'modules/auth/forgot_password.dart';
import 'modules/perangkat_desa/pd_main.dart';
import 'modules/perangkat_desa/pages/pd_beranda.dart';
import 'modules/perangkat_desa/pages/pd_data.dart';
import 'modules/perangkat_desa/pages/pd_berita.dart';
import 'modules/perangkat_desa/pages/pd_akun.dart';
import 'modules/perangkat_desa/pages/data/users/pd_users.dart';
import 'modules/perangkat_desa/pages/data/users/pd_users_add.dart';
import 'modules/perangkat_desa/pages/data/users/pd_users_edit.dart';
import 'modules/perangkat_desa/pages/data/services/pd_services.dart';
import 'modules/perangkat_desa/pages/data/services/pd_services_form.dart';
import 'modules/perangkat_desa/pages/data/news/pd_news.dart';
import 'modules/perangkat_desa/pages/data/news/pd_news_form.dart';
import 'modules/perangkat_desa/pages/pd_data_requests.dart';
import 'modules/perangkat_desa/pages/pd_berita_detail.dart';
import 'modules/warga/wg_main.dart';
import 'modules/rt/rt_main.dart';

final _authController = AuthController();

final GoRouter appRouter = GoRouter(
  initialLocation: '/auth/login',
  redirect: (context, state) => _authController.redirectLogic(state.uri.path),
  routes: [
    // Auth
    GoRoute(path: '/auth/login', builder: (_, __) => const LoginPage()),
    GoRoute(path: '/auth/register', builder: (_, __) => const RegisterPage()),
    GoRoute(path: '/auth/forgot-password', builder: (_, __) => const ForgotPasswordPage()),

    // Perangkat Desa
    ShellRoute(
      builder: (context, state, child) => PerangkatDesaMain(child: child),
      routes: [
        GoRoute(path: '/pd/beranda', builder: (_, __) => const DesaBerandaPage()),
        GoRoute(path: '/pd/data', builder: (_, __) => const DesaDataPage()),
        GoRoute(path: '/pd/berita', builder: (_, __) => DesaBeritaPage()),
        GoRoute(path: '/pd/akun', builder: (_, __) => const DesaAkunPage()),
        GoRoute(path: '/pd/data/users', builder: (_, __) => const DesaDataUsersPage()),
        GoRoute(path: '/pd/data/users/add', builder: (_, __) => const DesaDataUsersAddPage()),
        GoRoute(path: '/pd/data/users/edit', builder: (_, state) => DesaDataUsersEditPage()),
        GoRoute(path: '/pd/data/services', builder: (_, __) => const DesaDataServicesPage()),
        GoRoute(path: '/pd/data/services/add', builder: (_, __) => const DesaDataServicesFormPage()),
        GoRoute(path: '/pd/data/services/edit', builder: (context, state) => DesaDataServicesFormPage(id: state.uri.queryParameters['id'])),
        GoRoute(path: '/pd/data/news', builder: (_, __) => const DesaDataNewsPage()),
        GoRoute(path: '/pd/data/news/add', builder: (_, __) => const DesaDataNewsFormPage()),
        GoRoute(path: '/pd/data/news/edit', builder: (context, state) => DesaDataNewsFormPage(id: state.uri.queryParameters['id'])),
        GoRoute(path: '/pd/data/requests', builder: (_, __) => const DesaDataRequestsPage()),

        GoRoute(
  path: '/pd/berita/detail',
  builder: (context, state) {
    final newsId = state.extra as String; // aman, pasti ada
    return DesaBeritaDetailPage(newsId: newsId);
  },
),  
        
      ],
    ),

    // Warga dan RT
    GoRoute(path: '/wg/main', builder: (_, __) => const WargaMain()),
    GoRoute(path: '/rt/main', builder: (_, __) => const RTMain()),
  ],
);
