import 'package:ecommerce/app/dependency_injection/di.dart';
import 'package:ecommerce/app/main_app.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DependencyInjection.setup();

  runApp(const MainApp());
}
