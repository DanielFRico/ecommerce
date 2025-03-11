import 'package:flutter/material.dart';

class ShoppingCar extends StatelessWidget {
  const ShoppingCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Here is your car!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Content here"), Text("side here")],
            )
          ],
        ),
      ),
    );
  }
}
