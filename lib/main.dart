import 'package:flutter/material.dart';
import 'package:responsi_wildan/ui/ikan_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const IkanPage(),
    );
  }
}
