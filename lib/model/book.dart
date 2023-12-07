class Book {
  int id;
  String title;
  String coverUrl;
  String author;

  Book.fromJson(Map json)
      : id = json['id'],
        coverUrl = json['cover_url'],
        author = json['author'],
        title = json['title'];

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'coverUrl': coverUrl,
      'author': author,
    };
  }
}
