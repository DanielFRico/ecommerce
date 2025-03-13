import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  final List<String> users = [
    'User 1',
    'User 2',
    'User 3',
    'User 4',
    'User 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index]),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UsersPage(),
  ));
}
