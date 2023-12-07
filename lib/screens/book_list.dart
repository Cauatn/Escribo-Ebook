import 'dart:convert';

import 'package:desafio_escriboo/data/book_api.dart';
import 'package:desafio_escriboo/model/book.dart';
import 'package:flutter/material.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<Book> bookList = <Book>[];

  void getBooksfromApi() async {
    BookApi.getBooks().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        bookList = list.map((model) => Book.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getBooksfromApi();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Breaking Bad Books"),
            ),
            body: Container(
              child: ListView.builder(
                  itemCount: bookList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(bookList[index].title),
                    );
                  }),
            )));
  }
}
