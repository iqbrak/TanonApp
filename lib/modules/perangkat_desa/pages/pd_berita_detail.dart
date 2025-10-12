// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class BeritaDetailPage extends StatelessWidget {
//   final VoidCallback onBack;

//   final String title;
//   final String image;
//   final String tanggal;
//   final String isi;
//   final String? penulis;

//   const BeritaDetailPage({
//     super.key,
//     required this.title,
//     required this.image,
//     required this.tanggal,
//     required this.isi,
//     this.penulis = "Admin",
//     required this.onBack,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//           Container(color: const Color(0xFFF2F6FF)),
//           SizedBox(
//             height: 200,
//             width: double.infinity,
//             child: Image.asset(
//               image,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Color(0xFF245BCA)),
//                   onPressed: onBack, // <— ini diganti
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             top: 160,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(24),
//                   topRight: Radius.circular(24),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 10,
//                     offset: Offset(0, -3),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: GoogleFonts.poppins(
//                           fontSize: 20,
//                           fontWeight: FontWeight.w700,
//                           color: const Color(0xFF00194A),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           const Icon(Icons.calendar_today,
//                               size: 14, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           Text(
//                             tanggal,
//                             style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           const Icon(Icons.person,
//                               size: 14, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           Text(
//                             penulis ?? "Admin",
//                             style: GoogleFonts.poppins(
//                               fontSize: 12,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         isi,
//                         textAlign: TextAlign.justify,
//                         style: GoogleFonts.poppins(
//                           fontSize: 14,
//                           color: Colors.black87,
//                           height: 1.6,
//                         ),
//                       ),
//                       const SizedBox(height: 24),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Mengunduh file media...'),
//                               ),
//                             );
//                           },
//                           icon: const Icon(Icons.download, color: Colors.white),
//                           label: Text(
//                             'Unduh File Media',
//                             style: GoogleFonts.poppins(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF245BCA),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14),
//                             ),
//                             elevation: 5,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
