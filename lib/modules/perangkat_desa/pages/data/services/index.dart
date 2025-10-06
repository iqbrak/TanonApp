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
      "name": "Pembuatan KTP Baru",
      "description": "Kartu Tanda Penduduk",
      "requirements": ["Fotokopi KK", "Pas foto 3x4"]
    },
    {
      "id": "2",
      "name": "Pembuatan KK",
      "description": "Kartu Keluarga",
      "requirements": ["Surat nikah", "Foto seluruh anggota keluarga"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 60, bottom: 80),
            child: Column(
              children: dummyData.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: _buildExpandableCard(
                    context,
                    id: item["id"],
                    name: item["name"],
                    description: item["description"],
                    requirements: List<String>.from(item["requirements"]),
                  ),
                );
              }).toList(),
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
            builder: (context) => Padding(
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
      required String description,
      required List<String> requirements}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFCEDDFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF00194A), width: 1.5),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        title: Row(
          children: [
            Container(
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
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF00194A),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 20, color: Color(0xFF245BCA)),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: EditServicePage(
                          data: {
                            "id": id,
                            "name": name,
                            "description": description,
                            "requirements": requirements,
                          },
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 20, color: Color(0xFFCA2424)),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text(description, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
          const SizedBox(height: 6),
          Text("Persyaratan: ${requirements.join(', ')}",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[800])),
        ],
      ),
    );
  }
}