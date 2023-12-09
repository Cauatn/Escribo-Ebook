import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const stringKey = "StringKey";
const stringListKey = "stringListKey";

class BookApi {
  static Future getBooks() {
    return http.get(Uri.parse("https://escribo.com/books.json"));
  }

  static salvarString(value) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    shared.setString(stringKey, value);
    debugPrint("$value");
  }

  static salvarListaString(List<String> lista) async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    shared.setStringList(stringListKey, lista);
    debugPrint(lista.toString());
  }

  static Future<String> getString() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return shared.getString(stringKey) ?? "Vazio";
  }

  static Future<List<String>> getStringList() async {
    SharedPreferences shared = await SharedPreferences.getInstance();

    return shared.getStringList(stringListKey) ?? [];
  }
}
