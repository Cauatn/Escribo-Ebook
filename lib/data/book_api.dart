import 'dart:async';
import 'package:http/http.dart' as http;

class BookApi {
  static Future getBooks() {
    return http.get(Uri.parse("https://escribo.com/books.json"));
  }
}
