import 'package:flutter/material.dart';
import 'package:photos/app/routes/app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
