// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class EditServicePage extends StatefulWidget {
//   final Map<String, dynamic> data;
//   const EditServicePage({super.key, required this.data});

//   @override
//   State<EditServicePage> createState() => _EditServicePageState();
// }

// class _EditServicePageState extends State<EditServicePage> {
//   late TextEditingController _nameController;
//   late TextEditingController _descController;
//   late TextEditingController _reqController;

//   @override
//   void initState() {
//     super.initState();
//     _nameController = TextEditingController(text: widget.data['name']);
//     _descController = TextEditingController(text: widget.data['description']);
//     _reqController = TextEditingController(text: (widget.data['requirements'] as List).join(', '));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         left: 16,
//         right: 16,
//         top: 16,
//         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//       ),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text('Edit Keperluan', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 12),
//             Form(
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(labelText: 'Nama Keperluan'),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _descController,
//                     decoration: const InputDecoration(labelText: 'Deskripsi'),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _reqController,
//                     decoration: const InputDecoration(labelText: 'Persyaratan (pisah dengan koma)'),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context); 
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF245BCA),
//                       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       elevation: 5,
//                     ),
//                     child: Text(
//                       'Ubah',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
