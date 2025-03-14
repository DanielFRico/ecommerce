import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String photoURL;
  final String email;
  final Timestamp createdAt;

  UserModel(
      {required this.id,
      required this.name,
      required this.photoURL,
      required this.email,
      required this.createdAt});

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      name: data['name'] ?? '',
      photoURL: data['photoURL'] ?? '',
      email: data['email'] ?? '',
      createdAt: data['createdAt'] ?? '',
    );
  }
}
