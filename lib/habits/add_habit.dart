import 'package:flutter/material.dart';
import 'package:lifehq/skeleton.dart';

class AddHabit extends StatefulWidget {
  AddHabit({Key? key}) : super(key: key);

  static const routeName = '/add-habit';

  @override
  _AddHabitState createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Container(),
    );
  }
}
