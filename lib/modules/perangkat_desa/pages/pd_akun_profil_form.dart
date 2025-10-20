import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../../core/controllers/user_controller.dart';
import 'package:go_router/go_router.dart';

class DesaAkunProfilFormPage extends StatefulWidget {
  const DesaAkunProfilFormPage({super.key});

  @override
  State<DesaAkunProfilFormPage> createState() => _DesaAkunProfilFormPageState();
}

class _DesaAkunProfilFormPageState extends State<DesaAkunProfilFormPage> {
  final _formKey = GlobalKey<FormState>();
  final controller = UserController();

  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController birthPlaceController;
  late TextEditingController birthDateController;
  late TextEditingController rtController;
  late TextEditingController rwController;
  late TextEditingController dusunController;
  late TextEditingController phoneController;
  late TextEditingController occupationController;

  String? selectedReligion;
  String? selectedNationality;
  String? selectedMaritalStatus;
  String? selectedRole;

  bool isLoading = true;
  String? userId;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    birthPlaceController = TextEditingController();
    birthDateController = TextEditingController();
    rtController = TextEditingController();
    rwController = TextEditingController();
    dusunController = TextEditingController();
    phoneController = TextEditingController();
    occupationController = TextEditingController();

    _loadUser();
  }

  Future<void> _loadUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    userId = currentUser.uid;

    final user = await controller.getUserById(userId!);
    if (user != null) {
      usernameController.text = user.username;
      emailController.text = user.email;
      passwordController.text = user.password;

      if (user.birthPlaceDate.isNotEmpty && user.birthPlaceDate.contains(',')) {
        final parts = user.birthPlaceDate.split(',');
        birthPlaceController.text = parts[0].trim();
        birthDateController.text = parts[1].trim();
      } else {
        birthPlaceController.text = user.birthPlaceDate;
        birthDateController.text = '';
      }

      selectedReligion = user.religion.isNotEmpty ? user.religion : null;
      selectedNationality = user.nationality.isNotEmpty ? user.nationality : null;
      selectedMaritalStatus = user.maritalStatus.isNotEmpty ? user.maritalStatus : null;
      selectedRole = user.role.isNotEmpty ? user.role : null;

      occupationController.text = user.occupation;

      if (user.address.isNotEmpty && user.address.contains(',')) {
        final parts = user.address.split(',');
        rtController.text = parts.length > 0 ? parts[0].trim() : '';
        rwController.text = parts.length > 1 ? parts[1].trim() : '';
        dusunController.text = parts.length > 2 ? parts[2].trim() : '';
      } else {
        rtController.text = user.rt;
        rwController.text = '';
        dusunController.text = '';
      }

      phoneController.text = user.phone;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    birthPlaceController.dispose();
    birthDateController.dispose();
    rtController.dispose();
    rwController.dispose();
    dusunController.dispose();
    phoneController.dispose();
    occupationController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      String address =
          "${rtController.text.trim()}, ${rwController.text.trim()}, ${dusunController.text.trim()}";
      String rt = rtController.text.trim();

      await controller.updateUser(
        id: userId!,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        birthPlace: birthPlaceController.text,
        birthDate: birthDateController.text,
        religion: selectedReligion!,
        nationality: selectedNationality!,
        occupation: occupationController.text,
        maritalStatus: selectedMaritalStatus!,
        rt: rt,
        address: address,
        phone: phoneController.text,
        role: selectedRole!,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui')),
      );
      context.go('/pd/akun/profil');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF2F6FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00194A)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Ubah Profil",
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
              _buildTextField('Username', usernameController),
              const SizedBox(height: 16),
              _buildTextField('Email', emailController, enabled: false),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField('Tempat Lahir', birthPlaceController)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: birthDateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Lahir',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          birthDateController.text =
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        }
                      },
                      validator: (value) =>
                          value!.isEmpty ? 'Tanggal lahir tidak boleh kosong' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                'Agama',
                selectedReligion,
                ['Islam', 'Kristen', 'Katolik', 'Hindu', 'Buddha', 'Konghucu'],
                (v) => setState(() => selectedReligion = v),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      'Kewarganegaraan',
                      selectedNationality,
                      ['WNI', 'WNA'],
                      (v) => setState(() => selectedNationality = v),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildDropdown(
                      'Status Pernikahan',
                      selectedMaritalStatus,
                      ['Lajang', 'Menikah', 'Duda', 'Janda'],
                      (v) => setState(() => selectedMaritalStatus = v),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField('Pekerjaan', occupationController, required: false),
              const SizedBox(height: 16),
              _buildTextField('No. HP', phoneController),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 60, child: _buildTextField('RT', rtController)),
                  const SizedBox(width: 8),
                  SizedBox(width: 60, child: _buildTextField('RW', rwController)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTextField('Dusun', dusunController)),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF245BCA),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _save,
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool required = true, bool enabled = true}) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) =>
          required && value!.isEmpty ? '$label tidak boleh kosong' : null,
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> items,
      Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) => v == null ? '$label harus dipilih' : null,
    );
  }
}