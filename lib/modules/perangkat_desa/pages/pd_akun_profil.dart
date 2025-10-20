import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class DesaAkunProfilPage extends StatefulWidget {
  const DesaAkunProfilPage({super.key});

  @override
  State<DesaAkunProfilPage> createState() => _DesaAkunProfilPageState();
}

class _DesaAkunProfilPageState extends State<DesaAkunProfilPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? _userData;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final doc = await _firestore.collection('users').doc(currentUser.uid).get();

    if (!mounted) return;

    if (doc.exists) {
      setState(() {
        _userData = doc.data();
        _loading = false;
      });
    } else {
      setState(() => _loading = false);
    }
  }

  String _formatAddress(String address) {
    if (address.isEmpty || address == '-') return '-';

    final parts = address.split(',').map((e) => e.trim()).toList();

    String rt = parts.isNotEmpty ? parts[0] : '-';
    String rw = parts.length > 1 ? parts[1] : '-';
    String dusun = parts.length > 2 ? parts[2] : '-';

    return 'RT $rt/ RW $rw, Dsn. $dusun';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg_top.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 16,
                        right: 16,
                        child: Column(
                          children: [
                            Text(
                              'Profil Saya',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF00194A),
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      transform: Matrix4.translationValues(0, -40, 0),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Color(0xFF4E82EA),
                            child: Icon(Icons.person, size: 50, color: Colors.white),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _userData?['username'] ?? 'Tidak ada nama',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF00194A),
                            ),
                          ),
                          Text(
                            _userData?['role'] ?? 'Warga Desa',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F9FF),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFF4E82EA)),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                _infoRow('Email', _userData?['email'] ?? '-'),
                                _infoRow('Tempat & Tgl Lahir', _userData?['birthPlaceDate'] ?? '-'),
                                _infoRow('Agama', _userData?['religion'] ?? '-'),
                                _infoRow('Kewarganegaraan', _userData?['nationality'] ?? '-'),
                                _infoRow('Pekerjaan', _userData?['occupation'] ?? '-'),
                                _infoRow('Status Perkawinan', _userData?['maritalStatus'] ?? '-'),
                                _infoRow('Alamat', _formatAddress(_userData?['address'] ?? '-')),
                                _infoRow('No. HP', _userData?['phone'] ?? '-'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.go('/pd/akun/profil/form');
                              },
                              icon: const Icon(Icons.edit, color: Colors.white),
                              label: Text(
                                'Ubah Profil',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF245BCA),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF00194A),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}