import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Learning App'),
      ),
      body: ListView(
        children: [
          CategoryCard('Fruits'),
          CategoryCard('Animals'),
          CategoryCard('Colors'),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;

  CategoryCard(this.category);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(category),
        onTap: () {
          // Навигация на экран с карточками
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WordCardScreen(category),
            ),
          );
        },
      ),
    );
  }
}

class WordCardScreen extends StatefulWidget {
  final String category;

  WordCardScreen(this.category);

  @override
  _WordCardScreenState createState() => _WordCardScreenState();
}

class _WordCardScreenState extends State<WordCardScreen> {
  List<Map<String, String>> words = [
    {'word': 'Apple', 'translation': 'Яблоко'},
    {'word': 'Banana', 'translation': 'Банан'},
    {'word': 'Cat', 'translation': 'Кошка'},
  ];

  int currentIndex = 0;
  bool isAnswerVisible = false;

  void showAnswer() {
    setState(() {
      isAnswerVisible = true;
    });
  }

  void nextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % words.length;
      isAnswerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final word = words[currentIndex]['word'];
    final translation = words[currentIndex]['translation'];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              word ?? '',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            if (isAnswerVisible)
              Text(
                translation ?? '',
                style: TextStyle(fontSize: 30, color: Colors.green),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showAnswer,
              child: Text('Показать перевод'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextCard,
              child: Text('Следующая карточка'),
            ),
          ],
        ),
      ),
    );
  }
}
