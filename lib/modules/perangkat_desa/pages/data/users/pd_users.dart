import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class DesaDataUsersPage extends StatelessWidget {
  const DesaDataUsersPage({super.key});

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
    {
      "id": "5",
      "name": "Iqbra Kurniawan",
      "email": "iqbra@mail.com",
      "role": "Warga"
    },
    {
      "id": "6",
      "name": "Wahyu Nugroho",
      "email": "wahyu@mail.com",
      "role": "Perangkat Desa"
    },
    {
      "id": "7",
      "name": "Chalimatus Sa'diyah",
      "email": "halima@mail.com",
      "role": "Warga"
    },
    {
      "id": "8",
      "name": "Safira Nabila Bilqis",
      "email": "nabila@mail.com",
      "role": "RT"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Color(0xFF00194A)),
                      onPressed: () => context.go('/pd/data'),
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
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari pengguna...',
                      prefixIcon:
                          const Icon(Icons.search, color: Color(0xFF00194A)),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color(0xFF00194A), width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                            color: Color(0xFF00194A), width: 1.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: dummyData.length,
                itemBuilder: (context, index) {
                  final item = dummyData[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: _buildExpandableCard(
                      context,
                      id: item["id"],
                      name: item["name"],
                      email: item["email"],
                      role: item["role"],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/pd/data/users/add'),
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
        tilePadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF00194A))),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF245BCA)),
              onPressed: () => context.go('/pd/data/users/edit?id=$id'),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color(0xFFCA2424)),
              onPressed: () {},
            ),
          ],
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Text("Email: $email",
              style: GoogleFonts.poppins(
                  fontSize: 12, color: Colors.grey[700])),
          const SizedBox(height: 4),
          Text("Role: $role",
              style: GoogleFonts.poppins(
                  fontSize: 12, color: Colors.grey[800])),
        ],
      ),
    );
  }
}