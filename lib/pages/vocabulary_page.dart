import 'package:flutter/material.dart';

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> {
  final List<VocabularyItem> vocabularyList = [
    VocabularyItem(
      word: 'Hello',
      meaning: '哈囉',
      example: 'Hello, how are you?',
      pronunciation: '/həˈləʊ/',
    ),
    VocabularyItem(
      word: 'World',
      meaning: '世界',
      example: 'The world is beautiful.',
      pronunciation: '/wɜːld/',
    ),
    VocabularyItem(
      word: 'Learning',
      meaning: '學習',
      example: 'I am learning English.',
      pronunciation: '/ˈlɜːnɪŋ/',
    ),
  ];

  bool isShowingAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: vocabularyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildVocabularyCard(vocabularyList[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      isShowingAnswer = !isShowingAnswer;
                    });
                  },
                  icon: Icon(isShowingAnswer ? Icons.visibility_off : Icons.visibility),
                  label: Text(isShowingAnswer ? 'Hide Answer' : 'Show Answer'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add to review list
                  },
                  icon: const Icon(Icons.bookmark_border),
                  label: const Text('Review Later'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVocabularyCard(VocabularyItem item) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.word,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              item.pronunciation,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
            const SizedBox(height: 24),
            if (isShowingAnswer) ...[
              Text(
                item.meaning,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                item.example,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class VocabularyItem {
  final String word;
  final String meaning;
  final String example;
  final String pronunciation;

  VocabularyItem({
    required this.word,
    required this.meaning,
    required this.example,
    required this.pronunciation,
  });
}