import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add.dart';
import 'edit.dart';

class ServicesIndexPage extends StatelessWidget {
  final VoidCallback onBack;

  const ServicesIndexPage({super.key, required this.onBack});

  static const List<Map<String, dynamic>> dummyData = [
    {
      "id": "1",
      "name": "Pembuatan Surat Domisili",
      "requirements": ["Fotokopi KK", "Fotokopi KTP"],
      "description": "Layanan untuk membuat surat keterangan domisili bagi warga yang berdomisili di wilayah desa."
    },
    {
      "id": "2",
      "name": "Pengajuan KTP Baru",
      "requirements": ["Fotokopi KK", "Pas Foto 3x4", "Surat Pengantar RT/RW"],
      "description": "Proses pembuatan KTP baru bagi warga yang baru berusia 17 tahun atau belum memiliki KTP."
    },
    {
      "id": "3",
      "name": "Perbaikan Data KK",
      "requirements": ["Fotokopi KK Lama", "Fotokopi KTP", "Dokumen Pendukung"],
      "description": "Layanan untuk memperbaiki atau memperbarui data keluarga yang tercantum dalam Kartu Keluarga (KK)."
    },
    {
      "id": "4",
      "name": "Surat Izin Usaha Mikro (SIUM)",
      "requirements": ["Fotokopi KTP", "Surat Keterangan Usaha dari RT/RW"],
      "description": "Layanan untuk mengurus surat izin usaha mikro dan kecil bagi warga desa."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 65, bottom: 80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari keperluan...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF00194A)),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFF00194A), width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Color(0xFF00194A), width: 1.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...dummyData.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _buildExpandableCard(
                      context,
                      id: item["id"],
                      name: item["name"],
                      requirements: List<String>.from(item["requirements"]),
                      description: item["description"],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Positioned(
            top: 20,
            left: 16,
            right: 16,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF00194A)),
                  onPressed: onBack,
                ),
                const SizedBox(width: 8),
                Text(
                  'Data Keperluan',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00194A),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const AddServicePage(),
            ),
          );
        },
        backgroundColor: const Color(0xFF245BCA),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildExpandableCard(BuildContext context,
      {required String id,
      required String name,
      required List<String> requirements,
      required String description}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCEDDFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00194A), width: 1.5),
      ),
      child: ExpansionTile(
        key: PageStorageKey<String>(id),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage('assets/images/list_services.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          name,
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF00194A)),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF245BCA)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (_) => Padding(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: EditServicePage(
                      data: {
                        "id": id,
                        "name": name,
                        "requirements": requirements,
                        "description": description,
                      },
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color(0xFFCA2424)),
              onPressed: () {},
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text("Deskripsi:",
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF00194A))),
          Text(description,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
          const SizedBox(height: 8),
          Text("Persyaratan:",
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF00194A))),
          const SizedBox(height: 4),
          ...requirements.map((req) => Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Row(
                  children: [
                    const Icon(Icons.circle, size: 6, color: Color(0xFF00194A)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        req,
                        style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
