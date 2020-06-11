import 'dart:convert';

List<int> parseTopStories(String jsonStr) {
  final parsed = json.decode(jsonStr);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Article parseArticle(String jsonStr) {
  final parsed = json.decode(jsonStr);
  Article article = Article.fromJson(parsed);
  return article;
}

class Article {
  final String text;
  final String url;
  final String by;
  final int time;
  final int score;
  final int commentsCount;
  const Article(
      {this.text,
      this.url,
      this.by,
      this.time,
      this.score,
      this.commentsCount});

  factory Article.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return Article(
        text: json['text'] ?? '[null]',
        url: json['url'],
        by: json['by'],
        time: json['time'],
        score: json['score']);
  }
}
