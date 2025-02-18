import 'package:flutter/material.dart';

enum WordDifficulty { easy, medium, hard }

class VocabularyPage extends StatefulWidget {
  const VocabularyPage({super.key});

  @override
  State<VocabularyPage> createState() => _VocabularyPageState();
}

class _VocabularyPageState extends State<VocabularyPage> with SingleTickerProviderStateMixin {
  final List<VocabularyItem> vocabularyList = [
    VocabularyItem(
      word: 'Hello',
      meaning: '哈囉',
      example: 'Hello, how are you?',
      exampleTranslation: '哈囉，你好嗎？',
      pronunciation: '/həˈləʊ/',
      partOfSpeech: 'interjection',
      difficulty: WordDifficulty.easy,
      lastReviewDate: DateTime.now(),
      masterLevel: 0,
    ),
    VocabularyItem(
      word: 'World',
      meaning: '世界',
      example: 'The world is beautiful.',
      exampleTranslation: '世界是美麗的。',
      pronunciation: '/wɜːld/',
      partOfSpeech: 'noun',
      difficulty: WordDifficulty.medium,
      lastReviewDate: DateTime.now(),
      masterLevel: 0,
    ),
    VocabularyItem(
      word: 'Learning',
      meaning: '學習',
      example: 'I am learning English.',
      exampleTranslation: '我在學習英語。',
      pronunciation: '/ˈlɜːnɪŋ/',
      partOfSpeech: 'verb',
      difficulty: WordDifficulty.hard,
      lastReviewDate: DateTime.now(),
      masterLevel: 0,
    ),
  ];

  bool isShowingAnswer = false;
  late TabController _tabController;
  String searchQuery = '';
  WordDifficulty? filterDifficulty;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Flash Cards'),
            Tab(text: 'Word List'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              hintText: 'Search words...',
              leading: const Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFlashCardsView(),
                _buildWordListView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement quiz mode
        },
        child: const Icon(Icons.quiz),
      ),
    );
  }

  Widget _buildFlashCardsView() {
    final filteredList = vocabularyList.where((item) {
      final matchesSearch = item.word.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesDifficulty = filterDifficulty == null || item.difficulty == filterDifficulty;
      return matchesSearch && matchesDifficulty;
    }).toList();

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildVocabularyCard(filteredList[index]),
              );
            },
          ),
        ),
        _buildControlButtons(),
      ],
    );
  }

  Widget _buildWordListView() {
    final filteredList = vocabularyList.where((item) {
      final matchesSearch = item.word.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesDifficulty = filterDifficulty == null || item.difficulty == filterDifficulty;
      return matchesSearch && matchesDifficulty;
    }).toList();

    return ListView.separated(
      itemCount: filteredList.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = filteredList[index];
        return ListTile(
          title: Text(item.word),
          subtitle: Text('${item.partOfSpeech} - ${item.meaning}'),
          trailing: _buildProgressIndicator(item.masterLevel),
          onTap: () {
            // TODO: Show detailed word view
          },
        );
      },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDifficultyChip(item.difficulty),
                _buildProgressIndicator(item.masterLevel),
              ],
            ),
            const Spacer(),
            Text(
              item.word,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.pronunciation,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up),
                  onPressed: () {
                    // TODO: Implement text-to-speech
                  },
                ),
              ],
            ),
            Text(
              item.partOfSpeech,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const Spacer(),
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
              const SizedBox(height: 8),
              Text(
                item.exampleTranslation,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButtons() {
    return Padding(
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
    );
  }

  Widget _buildDifficultyChip(WordDifficulty difficulty) {
    final color = switch (difficulty) {
      WordDifficulty.easy => Colors.green,
      WordDifficulty.medium => Colors.orange,
      WordDifficulty.hard => Colors.red,
    };

    return Chip(
      label: Text(difficulty.name),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }

  Widget _buildProgressIndicator(int masterLevel) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < masterLevel ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }
}

class VocabularyItem {
  final String word;
  final String meaning;
  final String example;
  final String exampleTranslation;
  final String pronunciation;
  final String partOfSpeech;
  final WordDifficulty difficulty;
  final DateTime lastReviewDate;
  final int masterLevel;

  VocabularyItem({
    required this.word,
    required this.meaning,
    required this.example,
    required this.pronunciation,
    this.exampleTranslation = '',
    this.partOfSpeech = '',
    this.difficulty = WordDifficulty.medium,
    DateTime? lastReviewDate,
    this.masterLevel = 0,
  }) : lastReviewDate = lastReviewDate ?? DateTime.now();
}