import 'package:flutter/material.dart';

class HomeNavigatorObserver extends NavigatorObserver {
  final VoidCallback onPopNext;

  HomeNavigatorObserver({required this.onPopNext});

  void didPopNext() {
    onPopNext();
  }
}
