import 'package:flutter/material.dart';
import 'package:ecommerce/app/users/presentation/model/user.dart';
import 'package:ecommerce/app/core/data/remote/service/users_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final UserService _userService = UserService();
  late Future<List<UserModel>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _userService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Users',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<List<UserModel>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No users found'));
            } else {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(users[index].photoURL),
                    ),
                    title: Text(users[index].name),
                    subtitle: Text(
                      users[index].createdAt.toDate().toString(),
                      style: TextStyle(fontSize: 8),
                    ),
                    trailing: Text(users[index].email),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
