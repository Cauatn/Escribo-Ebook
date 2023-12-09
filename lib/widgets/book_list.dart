import 'dart:convert';
import 'dart:io';

import 'package:desafio_escriboo/data/book_api.dart';
import 'package:desafio_escriboo/model/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

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
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 0,
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 0,
        ),
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              //container imagem
              BookContainer(
                title: bookList[index].title,
                index: index,
                downLoadUrl: bookList[index].downloadUrl,
                coverUrl: bookList[index].coverUrl,
              ),
              //
              BottomText(
                title: bookList[index].title,
                author: bookList[index].author,
              ),
            ],
          );
        });
  }
}

class BottomText extends StatefulWidget {
  final String title;
  final String author;

  const BottomText({required this.title, required this.author, super.key});

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11)),
        Text(
          widget.author,
          style: const TextStyle(fontSize: 8),
        ),
      ],
    );
  }
}

class BookContainer extends StatefulWidget {
  final String downLoadUrl;
  final String coverUrl;
  final int index;
  final String title;

  const BookContainer(
      {required this.index,
      required this.title,
      required this.downLoadUrl,
      required this.coverUrl,
      super.key});

  @override
  State<BookContainer> createState() => _BookContainerState();
}

class _BookContainerState extends State<BookContainer> {
  List<String> selectedItem = [];

  @override
  void initState() {
    // TODO: implement initState
    initList();
    super.initState();
  }

  void initList() async {
    var temp = await BookApi.getStringList();
    selectedItem = temp as List<String>;
    if (selectedItem.isEmpty) {
      selectedItem = [];
    }

    setState(() {});
  }

  void setList(String title) async {
    selectedItem = await BookApi.getStringList();

    if (selectedItem.contains(title)) {
      selectedItem.remove(title);
    } else {
      selectedItem.add(title);
    }

    selectedItem = await BookApi.salvarListaString(selectedItem);
    debugPrint(selectedItem.toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 80,
          height: 90,
          child: GestureDetector(
            onTap: () {
              FileDownloader.downloadFile(
                  url: widget.downLoadUrl,
                  onDownloadError: (String error) {},
                  onDownloadCompleted: (path) {
                    final File file = File(path);
                  });
            },
            child: Image.network(
              widget.coverUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: -12,
          right: -12,
          child: IconButton(
            onPressed: () {
              //salvando titulo
              setList(widget.title);
              setState(() {});
            },
            icon: Icon(selectedItem.contains(widget.title)
                ? Icons.turned_in_outlined
                : Icons.turned_in_not_sharp),
            color:
                selectedItem.contains(widget.title) ? Colors.red : Colors.red,
            iconSize: 30,
          ),
        )
      ],
    );
  }
}
