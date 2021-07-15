import 'package:flutter/material.dart';

class Principles extends StatefulWidget {
  Principles({Key key}) : super(key: key);

  @override
  _PrinciplesState createState() => _PrinciplesState();
}

class _PrinciplesState extends State<Principles> {
  double nextOpacity = 0.0;
  int principleIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 4160), () {
      setState(() {
        nextOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Principles",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Spacer(),
                Opacity(
                  opacity: nextOpacity,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => Principles()));
                      },
                      child: Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ...[
              "Obstacle is the way.",
              "Ego is the enemy.",
              "Travel, Read and create."
            ].map((e) => Principle(
                  principle: e,
                  index: principleIndex++,
                ))
          ],
        ),
      ),
    );
  }
}

class Principle extends StatefulWidget {
  const Principle({
    Key key,
    @required this.principle,
    @required this.index,
  }) : super(key: key);

  final String principle;
  final int index;

  @override
  _PrincipleState createState() => _PrincipleState();
}

class _PrincipleState extends State<Principle> {
  double wholeOpactity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(
          seconds: widget.index * 2,
        ), () {
      setState(() {
        wholeOpactity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AnimatedOpacity(
          opacity: wholeOpactity,
          duration: Duration(seconds: 2),
          child: Text(widget.principle)),
    );
  }
}
