import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownScreen extends StatefulWidget {
  const MarkdownScreen({super.key, required this.mdContentUrl});

  final String mdContentUrl;

  @override
  State<MarkdownScreen> createState() => _MarkdownScreenState();
}

class _MarkdownScreenState extends State<MarkdownScreen> {
  late Future<String> mdContent;

  @override
  void initState() {
    super.initState();
    mdContent = fetchMdContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Markdown Sample"),
        ),
        body: FutureBuilder(
            future: mdContent,
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Markdown(data: snapshot.data.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
  }

  Future<String> fetchMdContent() async {
    final response = await http.get(Uri.parse(widget.mdContentUrl));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "##Failed to load data";
    }
  }
}
