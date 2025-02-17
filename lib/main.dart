import 'package:flutter/material.dart';
import 'pages/vocabulary_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'English Learning App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Learning'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            _buildFeatureCard(
              context,
              icon: Icons.book,
              title: 'Vocabulary',
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VocabularyPage(),
                  ),
                );
              },
            ),
            _buildFeatureCard(
              context,
              icon: Icons.record_voice_over,
              title: 'Speaking',
              color: Colors.green,
              onTap: () {
                // TODO: Navigate to speaking practice page
              },
            ),
            _buildFeatureCard(
              context,
              icon: Icons.headphones,
              title: 'Listening',
              color: Colors.orange,
              onTap: () {
                // TODO: Navigate to listening practice page
              },
            ),
            _buildFeatureCard(
              context,
              icon: Icons.edit_note,
              title: 'Grammar',
              color: Colors.purple,
              onTap: () {
                // TODO: Navigate to grammar page
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
