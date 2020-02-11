import 'dart:convert';

class News {
  final String status;
  final int totalResults;
  final List<Article> articles;
  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  News copyWith({
    String status,
    int totalResults,
    List<Article> articles,
  }) {
    return News(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': List<dynamic>.from(articles.map((x) => x.toMap())),
    };
  }

  static News fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return News(
      status: map['status'],
      totalResults: map['totalResults']?.toInt(),
      articles: List<Article>.from(map['articles']?.map((x) => Article.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static News fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'News status: $status, totalResults: $totalResults, articles: $articles';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is News &&
      o.status == status &&
      o.totalResults == totalResults &&
      o.articles == articles;
  }

  @override
  int get hashCode => status.hashCode ^ totalResults.hashCode ^ articles.hashCode;
}

class Article {
  final Source source;
  final Author author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  Article copyWith({
    Source source,
    Author author,
    String title,
    String description,
    String url,
    String urlToImage,
    String publishedAt,
    String content,
  }) {
    return Article(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'source': source.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  static Article fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Article(
      source: Source.fromMap(map['source']),
      author: map['author'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      urlToImage: map['urlToImage'],
      publishedAt: map['publishedAt'],
      content: map['content'],
    );
  }

  String toJson() => json.encode(toMap());

  static Article fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Article source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Article &&
      o.source == source &&
      o.author == author &&
      o.title == title &&
      o.description == description &&
      o.url == url &&
      o.urlToImage == urlToImage &&
      o.publishedAt == publishedAt &&
      o.content == content;
  }

  @override
  int get hashCode {
    return source.hashCode ^
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      publishedAt.hashCode ^
      content.hashCode;
  }
}

class Source {
  final String id;
  final String name;
  Source({
    this.id,
    this.name,
  });

  Source copyWith({
    String id,
    String name,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static Source fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Source(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  static Source fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Source id: $id, name: $name';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Source &&
      o.id == id &&
      o.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Author {
}