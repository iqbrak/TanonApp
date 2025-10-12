// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class DesaBeritaPage extends StatelessWidget {
//   final VoidCallback onOpenDetail;

//   const DesaBeritaPage({
//     super.key,
//     required this.onOpenDetail,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF2F6FF),
//       body: Column(
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 125,
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/bg_top.png'),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 35,
//                 left: 0,
//                 right: 0,
//                 child: Column(
//                   children: [
//                     Text(
//                       'Portal Berita Desa Tanon',
//                       style: GoogleFonts.poppins(
//                         color: const Color(0xFF00194A),
//                         fontSize: 24,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               decoration: InputDecoration(
//                                 hintText: 'Cari berita...',
//                                 prefixIcon: const Icon(Icons.search),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 filled: true,
//                                 fillColor: Colors.white,
//                                 contentPadding:
//                                     const EdgeInsets.symmetric(vertical: 0),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 16, vertical: 12),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF4E82EA),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child:
//                                 const Icon(Icons.filter_list, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: ListView.builder(
//                 itemCount: 10,
//                 itemBuilder: (context, index) {
//                   final berita = {
//                     'image': 'assets/images/berita.png',
//                     'title':
//                         'Judul Berita Pengumuman Dana Bansos Periode Juli 2025 Telah ada ${index + 1}',
//                     'tanggal': '06 Okt 2025, 12:00',
//                     'isi':
//                         'Isi lengkap berita ke-${index + 1}. Ini adalah contoh isi berita yang akan tampil di halaman detail.'
//                   };

//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: GestureDetector(
//                       onTap: onOpenDetail,
//                       child: _buildBeritaCard(context, berita),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBeritaCard(BuildContext context, Map<String, dynamic> berita) {
//     return Container(
//       height: 100,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(5),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Flexible(
//               flex: 1,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5),
//                 child: Image.asset(
//                   berita['image'],
//                   width: double.infinity,
//                   height: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             Flexible(
//               flex: 2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     berita['title'],
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600,
//                       color: const Color(0xFF00194A),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     berita['tanggal'],
//                     style: GoogleFonts.poppins(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DesaBeritaPage extends StatelessWidget {
  const DesaBeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ini Page Berita',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

