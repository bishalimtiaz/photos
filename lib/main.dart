import 'package:flutter/material.dart';
import 'package:photos/app/app.dart';
import 'package:photos/app/core/services/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppService().start();
  runApp(const App());
}
