import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html_main_element/html_main_element.dart';

class Zen extends StatefulWidget {
  Zen(this.url);

  final String url;

  @override
  _ZenState createState() => _ZenState();
}

class _ZenState extends State<Zen> {
  String? _bestElemReadability;

  @override
  void initState() {
    http.Client().get(Uri.parse(widget.url)).then((response) {
      var doc = html_parser.parse(response.bodyBytes);
      // final scoreMapReadability = readabilityScore(doc.documentElement!);
      setState(() {
        _bestElemReadability =
            readabilityMainElement(doc.documentElement!).innerHtml.toString();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 0),
        child: Expanded(
          child: SingleChildScrollView(
            child: Html(
              data: _bestElemReadability,
            ),
          ),
        ),
      ),
    );
  }
}
