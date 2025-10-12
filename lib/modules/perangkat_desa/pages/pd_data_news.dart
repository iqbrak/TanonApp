import 'package:flutter/material.dart';

class DesaDataNewsPage extends StatelessWidget {
  const DesaDataNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        title: const Text('Data Berita'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF00194A),
      ),
      body: const Center(
        child: Text(
          'Ini Page Data Pengguna',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
