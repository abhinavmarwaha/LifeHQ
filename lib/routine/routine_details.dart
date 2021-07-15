import 'package:flutter/material.dart';
import 'package:lifehq/routine/models/routine.dart';

class RoutineDetails extends StatelessWidget {
  const RoutineDetails({
    Key key,
    @required this.routine,
  }) : super(key: key);

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [],
        )));
  }
}
