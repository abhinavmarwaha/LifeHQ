import 'package:flutter/material.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/routine/feel.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class Principles extends StatefulWidget {
  Principles({Key? key}) : super(key: key);

  static const routeName = '/principles';

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
    return Skeleton(
      child: Consumer<KnowledgeService>(
        builder: (context, provider, child) => Column(
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
                        RoutineService routineService =
                            Provider.of<RoutineService>(context, listen: false);
                        int routineCheck = routineService.checkIfRoutined();
                        switch (routineCheck) {
                          case -1:
                            Navigator.pushNamed(context, Home.routeName);
                            break;
                          case 0:
                            routineService.startRoutine(0);
                            Navigator.pushNamed(context, Feel.routeName);
                            break;
                          case 1:
                            routineService.startRoutine(1);
                            Navigator.pushNamed(context, Feel.routeName);
                            break;
                          case -2:
                            throw Error();
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            ...provider.principles.map((e) => Principle(
                  principle: e.title,
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
    Key? key,
    required this.principle,
    required this.index,
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
