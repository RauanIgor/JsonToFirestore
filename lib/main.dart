import 'dart:async';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_to_firestore/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON to Firestore',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<void> enviarDadosParaFirestore() async {
    String jsonString = await lerArquivoJson();
    List<dynamic> jsonDataList = json.decode(jsonString);

    for (var jsonData in jsonDataList) {
      await FirebaseFirestore.instance.collection('livros').add(jsonData);
    }

    print('Dados enviados com sucesso para o Firestore');
  }

  Future<String> lerArquivoJson() async {
    return await rootBundle.loadString('assets/data.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON to Firestore'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            enviarDadosParaFirestore();
          },
          child: Text('Enviar dados para o Firestore'),
        ),
      ),
    );
  }
}

