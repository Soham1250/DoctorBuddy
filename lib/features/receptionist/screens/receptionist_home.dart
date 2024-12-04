import 'package:flutter/material.dart';

class ReceptionistHome extends StatelessWidget {
  const ReceptionistHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receptionist Dashboard'),
      ),
      body: const Center(
        child: Text('Receptionist Interface'),
      ),
    );
  }
}
