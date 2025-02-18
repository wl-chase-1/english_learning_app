import 'package:flutter/material.dart';

class ListeningPage extends StatelessWidget {
  const ListeningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening Practice'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildAudioLesson(
            title: 'Daily Conversation',
            description: 'Basic everyday conversations',
            duration: '5:30',
          ),
          _buildAudioLesson(
            title: 'Business Meeting',
            description: 'Common phrases used in meetings',
            duration: '6:45',
          ),
          _buildAudioLesson(
            title: 'Travel Dialogue',
            description: 'Essential travel conversations',
            duration: '4:20',
          ),
          _buildAudioLesson(
            title: 'Phone Call Practice',
            description: 'How to handle phone conversations',
            duration: '7:15',
          ),
        ],
      ),
    );
  }

  Widget _buildAudioLesson({
    required String title,
    required String description,
    required String duration,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(Icons.headphones, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 4),
            Text(
              'Duration: $duration',
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.play_circle_filled, color: Colors.orange),
          iconSize: 40,
          onPressed: () {
            // TODO: Implement audio playback
          },
        ),
      ),
    );
  }
}