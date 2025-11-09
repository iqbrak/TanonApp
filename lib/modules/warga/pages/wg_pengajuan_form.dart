import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class WargaPengajuanFormPage extends StatefulWidget {
  const WargaPengajuanFormPage({super.key});

  @override
  State<WargaPengajuanFormPage> createState() => _WargaPengajuanFormPageState();
}

class _WargaPengajuanFormPageState extends State<WargaPengajuanFormPage> {
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> services = [
    {
      'name': 'Pembuatan KTP Baru',
      'requirements': [
        'Fotokopi KTP/akta anggota keluarga',
        'Fotokopi buku nikah/akta perkawinan jika sudah menikah',
        'Fotokopi akta perceraian jika berlaku',
        'Fotokopi ijazah terakhir anggota keluarga',
      ],
    },
    {
      'name': 'Pembuatan KK Baru',
      'requirements': [
        'Fotokopi KTP kepala keluarga',
        'Surat pengantar dari RT/RW',
        'Surat keterangan pindah jika dari luar daerah',
      ],
    },
    {
      'name': 'Perubahan Data KK',
      'requirements': [
        'KK lama',
        'Dokumen pendukung perubahan (akta lahir, nikah, cerai)',
      ],
    },
  ];

  String? selectedService;
  List<String> selectedRequirements = [];

  final TextEditingController nikController = TextEditingController();
  final TextEditingController tempatLahirController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController rtController = TextEditingController();
  final TextEditingController rwController = TextEditingController();
  final TextEditingController dusunController = TextEditingController();
  final TextEditingController kewarganegaraanController = TextEditingController();
  final TextEditingController agamaController = TextEditingController();
  final TextEditingController pekerjaanController = TextEditingController();
  final TextEditingController statusPerkawinanController = TextEditingController();

  @override
  void dispose() {
    nikController.dispose();
    tempatLahirController.dispose();
    tanggalLahirController.dispose();
    jenisKelaminController.dispose();
    rtController.dispose();
    rwController.dispose();
    dusunController.dispose();
    kewarganegaraanController.dispose();
    agamaController.dispose();
    pekerjaanController.dispose();
    statusPerkawinanController.dispose();
    super.dispose();
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
          onPressed: () => context.go('/wg/pengajuan'),
        ),
        title: Text(
          "Tambah Pengajuan",
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
              Text(
                "DATA KEPERLUAN",
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00194A)),
              ),
              const SizedBox(height: 8),

              DropdownButtonFormField<String>(
                value: selectedService,
                decoration: const InputDecoration(
                  labelText: 'Keperluan',
                  border: OutlineInputBorder(),
                ),
                items: services.map<DropdownMenuItem<String>>((service) {
                  final name = service['name'] as String;
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedService = value;
                    selectedRequirements = services
                        .firstWhere((s) => s['name'] == value)['requirements']
                        .cast<String>();
                  });
                },
              ),

              const SizedBox(height: 12),

              if (selectedService != null) ...[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "PERSYARATAN YANG DIPERLUKAN:",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: const Color(0xFF00194A)),
                      ),
                      const SizedBox(height: 6),
                      ...selectedRequirements.map((req) => Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("• ",
                                  style: TextStyle(fontSize: 12)),
                              Expanded(
                                child: Text(req,
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.grey[700])),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],

              Text(
                "DATA PRIBADI PENGAJU",
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00194A)),
              ),
              const SizedBox(height: 8),

              _buildTextField(nikController, 'NIK'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildTextField(tempatLahirController, 'Tempat Lahir')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTextField(tanggalLahirController, 'Tanggal Lahir')),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField(jenisKelaminController, 'Jenis Kelamin'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _buildTextField(rtController, 'RT')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTextField(rwController, 'RW')),
                  const SizedBox(width: 8),
                  Expanded(child: _buildTextField(dusunController, 'Dusun')),
                ],
              ),
              const SizedBox(height: 10),
              _buildTextField(kewarganegaraanController, 'Kewarganegaraan'),
              const SizedBox(height: 10),
              _buildTextField(agamaController, 'Agama'),
              const SizedBox(height: 10),
              _buildTextField(pekerjaanController, 'Pekerjaan'),
              const SizedBox(height: 10),
              _buildTextField(statusPerkawinanController, 'Status Perkawinan'),
              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF245BCA),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => context.go('/wg/pengajuan/success'),
                child: Text(
                  'Buat Pengajuan',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}