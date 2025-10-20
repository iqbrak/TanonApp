import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/controllers/user_controller.dart';
import '../../../../../core/models/user.dart';

class DesaDataUsersFormPage extends StatefulWidget {
  final String? id;
  const DesaDataUsersFormPage({super.key, this.id});

  @override
  State<DesaDataUsersFormPage> createState() => _DesaDataUsersFormPageState();
}

class _DesaDataUsersFormPageState extends State<DesaDataUsersFormPage> {
  final _formKey = GlobalKey<FormState>();

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

  final controller = UserController();
  bool isLoading = true;

  String? selectedReligion;
  String? selectedNationality;
  String? selectedMaritalStatus;
  String? selectedRole;

  bool get isEdit => widget.id != null;

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

    if (isEdit) _loadUser();
    else isLoading = false;
  }

  Future<void> _loadUser() async {
    final user = await controller.getUserById(widget.id!);
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
      String birthPlaceDate = "${birthPlaceController.text.trim()}, ${birthDateController.text.trim()}";
      String address = "${rtController.text.trim()}, ${rwController.text.trim()}, ${dusunController.text.trim()}";
      String rt = rtController.text.trim();

      if (isEdit) {
        await controller.updateUser(
          id: widget.id!,
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
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User berhasil diperbarui')));
      } else {
        await controller.addUser(
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
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User berhasil ditambahkan')));
      }

      context.go('/pd/data/users');
    } catch (e) {
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
          onPressed: () => context.go('/pd/data/users'),
        ),
        title: Text(
          isEdit ? "Ubah User" : "Tambah User",
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
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Username tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Email tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              if (!isEdit) ...[
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) => value!.isEmpty ? 'Password tidak boleh kosong' : null,
                ),
                const SizedBox(height: 16),
              ],
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: birthPlaceController,
                      decoration: const InputDecoration(
                        labelText: 'Tempat Lahir',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Tempat lahir tidak boleh kosong' : null,
                    ),
                  ),
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
                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";
                        }
                      },
                      validator: (value) => value!.isEmpty ? 'Tanggal lahir tidak boleh kosong' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedReligion,
                items: ['Islam','Kristen','Katolik','Hindu','Buddha','Konghucu']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => selectedReligion = value),
                decoration: const InputDecoration(
                  labelText: 'Agama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Agama harus dipilih' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedNationality,
                      items: ['WNI','WNA']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => setState(() => selectedNationality = value),
                      decoration: const InputDecoration(
                        labelText: 'Kewarganegaraan',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null ? 'Kewarganegaraan harus dipilih' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: selectedMaritalStatus,
                      items: ['Lajang','Menikah','Duda','Janda']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => setState(() => selectedMaritalStatus = value),
                      decoration: const InputDecoration(
                        labelText: 'Status Pernikahan',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null ? 'Status harus dipilih' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: occupationController,
                decoration: const InputDecoration(
                  labelText: 'Pekerjaan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'No. HP',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'No. HP tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: rtController,
                      decoration: const InputDecoration(
                        labelText: 'RT',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'RT tidak boleh kosong' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: rwController,
                      decoration: const InputDecoration(
                        labelText: 'RW',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'RW tidak boleh kosong' : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: dusunController,
                      decoration: const InputDecoration(
                        labelText: 'Dusun',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Dusun tidak boleh kosong' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedRole,
                items: ['Perangkat Desa','Warga','RT']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => selectedRole = value),
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null ? 'Role harus dipilih' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF245BCA),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _save,
                child: Text(
                  isEdit ? 'Simpan Perubahan' : 'Simpan',
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