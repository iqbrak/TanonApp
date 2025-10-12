// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class AddUserPage extends StatefulWidget {
//   const AddUserPage({super.key});

//   @override
//   State<AddUserPage> createState() => _AddUserPageState();
// }

// class _AddUserPageState extends State<AddUserPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   String? _selectedRole;

//   final List<String> _roles = ['Warga', 'Perangkat Desa', 'RT'];

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
//             Text(
//               'Tambah Pengguna',
//               style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 12),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: const InputDecoration(labelText: 'Nama'),
//                     validator: (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: const InputDecoration(labelText: 'Email'),
//                     validator: (value) => value!.isEmpty ? 'Email wajib diisi' : null,
//                   ),
//                   const SizedBox(height: 8),
//                   DropdownButtonFormField<String>(
//                     value: _selectedRole,
//                     decoration: const InputDecoration(labelText: 'Role'),
//                     items: _roles
//                         .map((role) => DropdownMenuItem(
//                               value: role,
//                               child: Text(role),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         _selectedRole = value;
//                       });
//                     },
//                     validator: (value) => value == null || value.isEmpty ? 'Role wajib diisi' : null,
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
