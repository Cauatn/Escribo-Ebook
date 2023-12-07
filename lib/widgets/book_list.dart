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
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                width: 100,
                child: Image.network(
                  bookList[index].coverUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Text(bookList[index].title, overflow: TextOverflow.ellipsis),
              Text(bookList[index].author),
            ],
          );
        });
  }
}
