import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart' as md;

class MarkdownScreen extends StatefulWidget {
  const MarkdownScreen({super.key, required this.mdContentUrl});
  final String mdContentUrl;

  @override
  State<MarkdownScreen> createState() => _MarkdownScreenState();

}

class _MarkdownScreenState extends State<MarkdownScreen> {
  late Future<md.Markdown> mdContent;

  @override
  void initState() {
    super.initState();
    mdContent = fetchMdContent();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<md.Markdown>(
        future: mdContent,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return md.Markdown(data: snapshot.data!.toString());
          } else if (snapshot.hasError) {
            return md.Markdown(data: '${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
    );
  }

  Future<md.Markdown> fetchMdContent() async {
    final response = await http.get(Uri.parse(widget.mdContentUrl));
    if (response.statusCode == 200) {
      return md.Markdown(data: response.body);
    } else {
      return const md.Markdown(data: "##Failed to load data");
    }
  }

}