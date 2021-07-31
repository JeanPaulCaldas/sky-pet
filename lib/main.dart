import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sky_pet/injection.dart';
import 'package:sky_pet/presentation/core/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureDependencies();
  runApp(AppWidget());
}
