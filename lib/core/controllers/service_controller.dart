import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/service.dart';

class ServiceController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "services";

  Stream<List<Service>> getServicesStream() {
    return _firestore.collection(collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Service.fromMap(data);
      }).toList();
    });
  }

  Future<Service?> getServiceById(String id) async {
    final doc = await _firestore.collection(collectionName).doc(id).get();
    if (doc.exists) {
      final data = doc.data()!;
      data['id'] = doc.id;
      return Service.fromMap(data);
    }
    return null;
  }

  Future<void> addService({
    required String name,
    required String description,
    required String requirementsRaw,
  }) async {
    List<String> requirements = _processRequirements(requirementsRaw);
    String id = _firestore.collection(collectionName).doc().id;

    final service = Service(
      id: id,
      name: name.trim(),
      description: description.trim(),
      requirements: requirements,
    );

    await _firestore.collection(collectionName).doc(id).set(service.toMap());
  }

  Future<void> updateService({
    required String id,
    required String name,
    required String description,
    required String requirementsRaw,
  }) async {
    List<String> requirements = _processRequirements(requirementsRaw);

    final service = Service(
      id: id,
      name: name.trim(),
      description: description.trim(),
      requirements: requirements,
    );

    await _firestore.collection(collectionName).doc(id).update(service.toMap());
  }

  Future<void> deleteService(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }

  Future<void> deleteServiceWithConfirmation(BuildContext context, String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Yakin ingin menghapus data?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCA2424),
            ),
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.white), 
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await deleteService(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keperluan berhasil dihapus')),
      );
    }
  }

  Stream<List<Service>> getFilteredServicesStream(String keyword) {
    keyword = keyword.toLowerCase();
    return _firestore.collection(collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Service.fromMap(data);
      }).where((service) => service.name.toLowerCase().contains(keyword)).toList();
    });
  }

  List<String> _processRequirements(String raw) {
    return raw
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
}
