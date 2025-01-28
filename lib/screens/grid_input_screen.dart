import 'package:flutter/material.dart';

class GridInputScreen extends StatefulWidget {
  const GridInputScreen({super.key});

  @override
  State<GridInputScreen> createState() => _GridInputScreenState();
}

class _GridInputScreenState extends State<GridInputScreen> {
  final TextEditingController rowsController = TextEditingController();
  final TextEditingController columnsController = TextEditingController();
  final TextEditingController lettersController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: rowsController,
              decoration: const InputDecoration(
                labelText: 'Number of Rows',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: columnsController,
              decoration: const InputDecoration(
                labelText: 'Number of Columns',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: lettersController,
              decoration: const InputDecoration(
                labelText: 'Enter Letters (rows*columns)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int m = int.tryParse(rowsController.text) ?? 0;
                int n = int.tryParse(columnsController.text) ?? 0;
                String letters = lettersController.text;

                if (letters.length == m * n && m > 0 && n > 0) {
                  Navigator.pushNamed(context, '/gridDisplay', arguments: {
                    'rows': m,
                    'columns': n,
                    'letters': letters,
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Invalid input. Ensure rows*columns matches letters.'),
                  ));
                }
              },
              child: const Text(
                'Create Grid',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
