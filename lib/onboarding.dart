import 'package:flutter/material.dart';
import 'package:lifehq/skeleton.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO Onboarding
    return Skeleton(
      child: YearPicker(
        firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
        lastDate: DateTime.now(),
        selectedDate: DateTime.now(),
        onChanged: (value) => null,
      ),
    );
  }
}
