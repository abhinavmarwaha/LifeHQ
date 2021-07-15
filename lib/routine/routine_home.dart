import 'package:flutter/material.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:provider/provider.dart';

class RoutineHome extends StatefulWidget {
  const RoutineHome({Key key}) : super(key: key);

  @override
  _RoutineHomeState createState() => _RoutineHomeState();
}

class _RoutineHomeState extends State<RoutineHome> {
  bool morningSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Center(
                child: Column(children: [
          Row(children: [
            Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  morningSelected = true;
                });
              },
              child: morningSelected
                  ? SelectedHeading(text: "Morning")
                  : UnselectedHeading(text: "Morning"),
            ),
            SizedBox(
              width: 12,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  morningSelected = false;
                });
              },
              child: !morningSelected
                  ? SelectedHeading(text: "Night")
                  : UnselectedHeading(text: "Night"),
            ),
            SizedBox(
              width: 40,
            ),
            Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.bar_chart, color: Colors.black))),
            Spacer()
          ]),
          Consumer<RoutineService>(
            builder: (context, provider, child) => Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: provider.routines
                    .where((element) =>
                        element.routineType == (morningSelected ? 0 : 1))
                    .map((e) => RoutineCard(routine: e))
                    .toList(),
              ),
            )),
          )
        ]))));
  }
}

class RoutineCard extends StatelessWidget {
  const RoutineCard({
    Key key,
    @required this.routine,
  }) : super(key: key);

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    return Card();
  }
}

class SelectedHeading extends StatelessWidget {
  const SelectedHeading({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class UnselectedHeading extends StatelessWidget {
  const UnselectedHeading({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
  }
}
