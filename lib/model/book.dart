class Book {
  int id;
  String title;
  //String url;
  //String coverUrl;

  Book.fromJson(Map json)
      : id = json['id'],
        title = json['title'];

  Map toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
