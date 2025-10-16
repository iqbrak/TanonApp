import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NewsUploadPage extends StatefulWidget {
  const NewsUploadPage({super.key});

  @override
  State<NewsUploadPage> createState() => _NewsUploadPageState();
}

class _NewsUploadPageState extends State<NewsUploadPage> {
  final SupabaseClient supabase = Supabase.instance.client;


  PlatformFile? thumbnailFile;
  List<PlatformFile> supportingFiles = [];
  bool isUploading = false;

  final String bucketName = 'TanonApp Storage';

  Future<void> _pickThumbnail() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        thumbnailFile = result.files.first;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belum pilih thumbnail')));
    }
  }

  Future<void> _pickSupportingFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        supportingFiles.addAll(result.files);
      });
    }
  }

  Future<void> _uploadFiles() async {
    if (thumbnailFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih thumbnail terlebih dahulu')));
      return;
    }

    setState(() => isUploading = true);

    try {
      final thumbPath = 'news/thumbnails/${thumbnailFile!.name}';
      await supabase.storage
          .from(bucketName)
          .uploadBinary(thumbPath, thumbnailFile!.bytes!);
      final thumbUrl = supabase.storage.from(bucketName).getPublicUrl(thumbPath);

      List<Map<String, String>> uploadedFiles = [];
      for (var f in supportingFiles) {
        final path = 'news/files/${f.name}';
        await supabase.storage.from(bucketName).uploadBinary(path, f.bytes!);
        final url = supabase.storage.from(bucketName).getPublicUrl(path);
        uploadedFiles.add({'name': f.name, 'url': url});
      }

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload berhasil')));
      setState(() {
        thumbnailFile = null;
        supportingFiles.clear();
      });

      print('Thumbnail URL: $thumbUrl');
      print('Files URLs: $uploadedFiles');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload gagal: $e')));
    } finally {
      setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload News Files')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: _pickThumbnail,
                    child: const Text('Pilih Thumbnail')),
                const SizedBox(width: 12),
                if (thumbnailFile != null)
                  Expanded(
                    child: Text(
                      thumbnailFile!.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                ElevatedButton(
                    onPressed: _pickSupportingFiles,
                    child: const Text('Pilih Supporting Files')),
                const SizedBox(width: 12),
                Text("${supportingFiles.length} file dipilih"),
              ],
            ),
            if (supportingFiles.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: supportingFiles
                    .map((f) =>
                        Chip(label: Text(f.name, overflow: TextOverflow.ellipsis)))
                    .toList(),
              ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: isUploading ? null : _uploadFiles,
              icon: const Icon(Icons.cloud_upload),
              label: Text(isUploading ? "Mengunggah..." : "Upload"),
            ),
          ],
        ),
      ),
    );
  }
}