import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html_main_element/html_main_element.dart';
import 'package:lifehq/widgets/back_button.dart';

class Zen extends StatefulWidget {
  const Zen({
    required this.url,
    required this.title,
  });

  final String url;
  final String title;

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
        child: Column(
          children: [
            Row(
              children: [
                MyBackButton(),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _bestElemReadability == null
                    ? Center(child: CircularProgressIndicator())
                    : Html(
                        data: _bestElemReadability,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
