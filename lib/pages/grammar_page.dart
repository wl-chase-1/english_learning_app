import 'package:flutter/material.dart';

class GrammarPage extends StatelessWidget {
  const GrammarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grammar'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGrammarCard(
            title: 'Present Simple',
            description:
                'Used for habits, repeated actions, and general truths',
            example: 'I go to school every day.',
          ),
          _buildGrammarCard(
            title: 'Present Continuous',
            description:
                'Used for actions happening now or temporary situations',
            example: 'I am studying English now.',
          ),
          _buildGrammarCard(
            title: 'Past Simple',
            description: 'Used for completed actions in the past',
            example: 'I went to London last year.',
          ),
          _buildGrammarCard(
            title: 'Future Simple',
            description: 'Used for future predictions or spontaneous decisions',
            example: 'I will help you with your homework.',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGrammarCard({
    required String title,
    required String description,
    required String example,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text(
              'Example: $example',
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
