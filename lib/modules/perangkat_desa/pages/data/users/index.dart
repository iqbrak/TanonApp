import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add.dart';
import 'edit.dart';

class UsersIndexPage extends StatelessWidget {
  final VoidCallback onBack;

  const UsersIndexPage({super.key, required this.onBack});

  static const List<Map<String, dynamic>> dummyData = [
    {
      "id": "1",
      "name": "Iqbra Kurniawan",
      "email": "iqbra@mail.com",
      "role": "Warga"
    },
    {
      "id": "2",
      "name": "Wahyu Nugroho",
      "email": "wahyu@mail.com",
      "role": "Perangkat Desa"
    },
    {
      "id": "3",
      "name": "Chalimatus Sa'diyah",
      "email": "halima@mail.com",
      "role": "Warga"
    },
    {
      "id": "4",
      "name": "Safira Nabila Bilqis",
      "email": "nabila@mail.com",
      "role": "RT"
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
                      hintText: 'Cari pengguna...',
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
                      email: item["email"],
                      role: item["role"],
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
                  'Data Pengguna',
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
              child: const AddUserPage(),
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
      required String email,
      required String role}) {
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
              image: AssetImage('assets/images/list-users.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(name,
            style: GoogleFonts.poppins(
                fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF00194A))),
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
                    child: EditUserPage(
                      data: {
                        "id": id,
                        "name": name,
                        "email": email,
                        "role": role,
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
          Text("Email: $email", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700])),
          const SizedBox(height: 4),
          Text("Role: $role", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[800])),
        ],
      ),
    );
  }
}
