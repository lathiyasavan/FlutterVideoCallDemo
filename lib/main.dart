import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saumil/homescreen.dart';

List Vedio = [];
var id;
String Urlink = '';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splay(),
  ));
}

class Splay extends StatefulWidget {
  const Splay({Key? key}) : super(key: key);

  @override
  State<Splay> createState() => _SplayState();
}

class _SplayState extends State<Splay> {
  @override
  void initState() {
    Getvedio();
    Future.delayed(
      Duration(seconds: 4),
      () => Get.off(Homepage()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Getvedio() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'your api'));

    http.StreamedResponse response = await request.send();
    final respo = await response.stream.bytesToString();
    var val = jsonDecode(respo);

    if (response.statusCode == 200) {
      if (respo.isNotEmpty) {
        Vedio.clear();
        setState(() {});
        val['Randomvideocall'].forEach((element) {
          Vedio.add(element);
        });
        Vedio.shuffle();
        setState(() {});

        String a = Vedio[10]['Video_Name'];
        id = a.split('.');
        setState(() {});
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
