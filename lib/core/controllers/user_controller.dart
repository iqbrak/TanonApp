import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import 'package:flutter/material.dart';

class UserController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = "users";

  Stream<List<User>> getUsersStream() {
    return _firestore.collection(collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return User.fromMap(data);
      }).toList();
    });
  }

  Stream<int> getTotalUsers() {
    return getUsersStream().map((list) => list.length);
  }

  Future<User?> getUserById(String id) async {
    final doc = await _firestore.collection(collectionName).doc(id).get();
    if (doc.exists) {
      final data = doc.data()!;
      data['id'] = doc.id;
      return User.fromMap(data);
    }
    return null;
  }

  Future<void> addUser({
    required String username,
    required String email,
    required String password,
    required String birthPlace,
    required String birthDate,
    required String religion,
    required String nationality,
    required String occupation,
    required String maritalStatus,
    required String rt,
    required String address,
    required String phone,
    required String role,
  }) async {
    String id = _firestore.collection(collectionName).doc().id;

    final user = User(
      id: id,
      username: username.trim(),
      email: email.trim(),
      password: password.trim(),
      birthPlaceDate: '$birthPlace, $birthDate',
      religion: religion.trim(),
      nationality: nationality.trim(),
      occupation: occupation.trim(),
      maritalStatus: maritalStatus.trim(),
      rt: rt.trim(),
      address: address.trim(),
      phone: phone.trim(),
      role: role.trim(),
    );

    await _firestore.collection(collectionName).doc(id).set(user.toMap());
  }

  Future<void> updateUser({
    required String id,
    required String username,
    required String email,
    required String password,
    required String birthPlace,
    required String birthDate,
    required String religion,
    required String nationality,
    required String occupation,
    required String maritalStatus,
    required String rt,
    required String address,
    required String phone,
    required String role,
  }) async {
    final user = User(
      id: id,
      username: username.trim(),
      email: email.trim(),
      password: password.trim(),
      birthPlaceDate: '$birthPlace, $birthDate',
      religion: religion.trim(),
      nationality: nationality.trim(),
      occupation: occupation.trim(),
      maritalStatus: maritalStatus.trim(),
      rt: rt.trim(),
      address: address.trim(),
      phone: phone.trim(),
      role: role.trim(),
    );

    await _firestore.collection(collectionName).doc(id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _firestore.collection(collectionName).doc(id).delete();
  }

  Future<void> deleteUserWithConfirmation(BuildContext context, String id) async {
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
      await deleteUser(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User berhasil dihapus')),
      );
    }
  }

  Stream<List<User>> getFilteredUsersStream(String keyword) {
    keyword = keyword.toLowerCase();
    return _firestore.collection(collectionName).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return User.fromMap(data);
      }).where((user) => user.username.toLowerCase().contains(keyword)).toList();
    });
  }
}