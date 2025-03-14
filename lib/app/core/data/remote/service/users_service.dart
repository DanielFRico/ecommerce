import 'package:ecommerce/app/users/presentation/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getUsers() async {
    final QuerySnapshot snapshot = await _firestore.collection('users').get();
    return snapshot.docs
        .map((doc) =>
            UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }
}
