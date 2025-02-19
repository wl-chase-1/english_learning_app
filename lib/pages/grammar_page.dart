import 'package:flutter/material.dart';

class GrammarPage extends StatefulWidget {
  const GrammarPage({super.key});

  @override
  _GrammarPageState createState() => _GrammarPageState();
}

class _GrammarPageState extends State<GrammarPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = [
    'Tenses',
    'Parts of Speech',
    'Sentence Structure',
    'Common Mistakes',
  ];
  int _selectedIndex = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.purple,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Grammar Master'),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.purple.shade800],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit_note,
                          size: 60,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Your Progress: 65%',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabs:
                      _categories
                          .map((category) => Tab(text: category))
                          .toList(),
                  labelColor: Colors.purple,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.purple,
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children:
              _categories
                  .map((category) => _buildCategoryContent(category))
                  .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showPracticeDialog(context);
        },
        backgroundColor: Colors.purple,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Practice'),
      ),
    );
  }

  Widget _buildCategoryContent(String category) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildGrammarCard(category: category, index: index);
      },
    );
  }

  Widget _buildGrammarCard({required String category, required int index}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 100)),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: Icon(_getCategoryIcon(category), color: Colors.purple),
                title: Text(
                  _getGrammarTitle(category, index),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_getGrammarDescription(category, index)),
                        const SizedBox(height: 8),
                        _buildExampleWidget(
                          _getGrammarExample(category, index),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed:
                                  () =>
                                      _startPractice(context, category, index),
                              icon: const Icon(Icons.school),
                              label: const Text('Practice'),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed:
                                  () => _showNotes(context, category, index),
                              icon: const Icon(Icons.note_add),
                              label: const Text('Notes'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildExampleWidget(String example) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.format_quote, color: Colors.purple),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              example,
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Tenses':
        return Icons.access_time;
      case 'Parts of Speech':
        return Icons.category;
      case 'Sentence Structure':
        return Icons.architecture;
      case 'Common Mistakes':
        return Icons.warning;
      default:
        return Icons.book;
    }
  }

  String _getGrammarTitle(String category, int index) {
    // 示範用的標題
    final titles = {
      'Tenses': [
        'Present Simple',
        'Present Continuous',
        'Past Simple',
        'Past Continuous',
        'Future Simple',
      ],
      'Parts of Speech': [
        'Nouns',
        'Verbs',
        'Adjectives',
        'Adverbs',
        'Prepositions',
      ],
    };
    return titles[category]?[index] ?? 'Grammar Point ${index + 1}';
  }

  String _getGrammarDescription(String category, int index) {
    // 根據類別和索引返回描述
    return 'Learn how to use this grammar point effectively in your daily communication.';
  }

  String _getGrammarExample(String category, int index) {
    // 根據類別和索引返回示例
    return 'This is an example sentence demonstrating the usage.';
  }

  void _startPractice(BuildContext context, String category, int index) {
    // 實作練習功能
  }

  void _showNotes(BuildContext context, String category, int index) {
    // 實作筆記功能
  }

  void _showPracticeDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose Practice Type',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.quiz),
                  title: const Text('Multiple Choice Quiz'),
                  onTap: () {
                    Navigator.pop(context);
                    // 實作選擇題練習
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Fill in the Blanks'),
                  onTap: () {
                    Navigator.pop(context);
                    // 實作填空練習
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.sync_alt),
                  title: const Text('Sentence Transformation'),
                  onTap: () {
                    Navigator.pop(context);
                    // 實作句型轉換練習
                  },
                ),
              ],
            ),
          ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
