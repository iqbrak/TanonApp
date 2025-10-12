// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddServicePage extends StatefulWidget {
//   const AddServicePage({super.key});

//   @override
//   State<AddServicePage> createState() => _AddServicePageState();
// }

// class _AddServicePageState extends State<AddServicePage> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _descController = TextEditingController();
//   final _reqController = TextEditingController();

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
//             Text('Tambah Keperluan', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
//             const SizedBox(height: 12),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(labelText: 'Nama Keperluan'),
//                     validator: (value) => value!.isEmpty ? 'Tidak boleh kosong' : null,
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
//                       if (_formKey.currentState!.validate()) {
//                         Navigator.pop(context); 
//                       }
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
//                       'Tambah',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.white,
//                       ),
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
