import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: articles.length,
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          return ArticleCard(article: articles[index]);
        },
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailPage(article: article),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                article.summary,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${article.readingTime} min read',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.school,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    article.level,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${article.readingTime} min read',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.school,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  article.level,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              article.content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String summary;
  final String content;
  final int readingTime;
  final String level;

  const Article({
    required this.title,
    required this.summary,
    required this.content,
    required this.readingTime,
    required this.level,
  });
}

final List<Article> articles = [
  Article(
    title: 'The Benefits of Learning a New Language',
    summary: 'Discover how learning a new language can improve your brain function and open up new opportunities.',
    content: '''Learning a new language is one of the most rewarding experiences you can have. It not only helps you communicate with people from different cultures but also provides numerous cognitive benefits.

Research has shown that bilingual people have better memory, stronger problem-solving skills, and improved concentration. When you learn a new language, your brain creates new neural pathways, which can help prevent cognitive decline as you age.

Moreover, in today's globalized world, knowing multiple languages can give you a significant advantage in your career. Many companies value multilingual employees and offer better opportunities to those who can communicate in different languages.

So, whether you're learning English for personal growth or professional development, remember that every minute you spend studying is an investment in your future.''',
    readingTime: 3,
    level: 'Intermediate',
  ),
  Article(
    title: 'Tips for Effective English Communication',
    summary: 'Learn practical tips to improve your English communication skills in daily situations.',
    content: '''Effective communication in English requires more than just knowing grammar rules and vocabulary. Here are some practical tips to help you communicate more effectively:

1. Listen actively: Pay attention to how native speakers express themselves.
2. Practice regularly: Try to use English every day, even if just for a few minutes.
3. Don't be afraid of making mistakes: They are a natural part of learning.
4. Use simple words: Complex vocabulary isn't always better.
5. Focus on clarity: Make sure your message is clear and concise.

Remember, becoming fluent in English is a journey, not a destination. Take it one step at a time, and celebrate your progress along the way.''',
    readingTime: 2,
    level: 'Beginner',
  ),
  Article(
    title: 'The Future of Language Learning',
    summary: 'Explore how technology is changing the way we learn languages.',
    content: '''The way we learn languages is rapidly evolving thanks to technological advances. From AI-powered language apps to virtual reality immersion experiences, the future of language learning looks incredibly promising.

Artificial Intelligence can now provide personalized learning experiences, adapting to each student's pace and learning style. Virtual reality allows learners to practice their language skills in simulated real-world environments without the pressure of actual face-to-face interactions.

As these technologies continue to develop, language learning will become more accessible, engaging, and effective. However, the fundamental principles of dedication, practice, and patience remain crucial for success in language acquisition.''',
    readingTime: 4,
    level: 'Advanced',
  ),
];