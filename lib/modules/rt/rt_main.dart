import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:etanonapp/core/controllers/auth_controller.dart';

class RTMain extends StatelessWidget {
  const RTMain({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = AuthController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard RT'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () async {
              await authController.logout();
              context.go('/auth/login');
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to the Rete Gang',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
