import 'package:desafio_escriboo/data/book_api.dart';
import 'package:desafio_escriboo/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> lista = [];

  @override
  void initState() {
    // TODO: implement initState
    initFav();
    super.initState();
  }

  void initFav() async {
    var temp = BookApi.getStringList();
    lista = temp as List<String>;
    debugPrint(lista.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: const Text('livros')),
                ElevatedButton(
                    onPressed: () {
                      initFav();
                      setState(() {});
                    },
                    child: const Text('favoritos')),
              ],
            )
          ],
        ),
        body: HomeScreen(),
      ),
    );
  }
}
