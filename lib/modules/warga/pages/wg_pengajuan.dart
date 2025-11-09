import 'package:flutter/material.dart';

class WargaPengajuanPage extends StatelessWidget {
  const WargaPengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        title: const Text('Pengajuan'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: const Color(0xFF00194A),
      ),
      body: const Center(
        child: Text(
          'Ini Page Data Pengajuan Warga',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}