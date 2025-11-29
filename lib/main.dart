import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const BlockGuardsApp());
}

class BlockGuardsApp extends StatelessWidget {
  const BlockGuardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BlockGuards",
      home: const LoginPage(),
    );
  }
}
