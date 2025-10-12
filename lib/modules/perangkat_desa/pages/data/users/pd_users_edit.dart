import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class DesaDataUsersEditPage extends StatefulWidget {
  final String? id;
  const DesaDataUsersEditPage({super.key, this.id});

  @override
  State<DesaDataUsersEditPage> createState() => _DesaDataUsersEditPageState();
}

class _DesaDataUsersEditPageState extends State<DesaDataUsersEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: "Iqbra Kurniawan");
    emailController = TextEditingController(text: "iqbra@mail.com");
    selectedRole = "Warga";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00194A)),
          onPressed: () => context.go('/pd/data/users'),
        ),
        title: Text(
          "Ubah Pengguna",
          style: GoogleFonts.poppins(
            color: const Color(0xFF00194A),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Email tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Peran',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Warga', child: Text('Warga')),
                  DropdownMenuItem(value: 'RT', child: Text('RT')),
                  DropdownMenuItem(
                      value: 'Perangkat Desa', child: Text('Perangkat Desa')),
                ],
                onChanged: (val) => setState(() => selectedRole = val),
                validator: (val) =>
                    val == null ? 'Silakan pilih peran' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF245BCA),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Perubahan disimpan')),
                    );
                    context.go('/pd/data/users');
                  }
                },
                child: Text(
                  'Simpan Perubahan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
