import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  var titulo = "";
  var itemCount = 0;

  void _buscarLivros() async {
    titulo = _controller.text;
    final url = Uri.https(
      'www.googleapis.com',
      '/books/v1/volumes',
      {'q': '{$titulo}'},
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      itemCount = jsonResponse['totalItems'];
      print('Number of books about $titulo: $itemCount.');
      setState(() {});
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController LivrosController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('KEOB'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(45),
        child: ListView(
          children: [
            TextField(
              controller: _controller,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
                onPressed: _buscarLivros,
                icon: const Icon(Icons.search),
                label: const Text('pesquisar')),
            const SizedBox(height: 70),
            Text(
              'Encontramos $itemCount livros sobre $titulo ',
            ),
          ],
        ),
      ),
    );
  }
}
