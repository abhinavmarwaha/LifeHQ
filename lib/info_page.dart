import 'package:flutter/material.dart';
import 'package:lifehq/skeleton.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Skeleton(
        child: Column(
      children: [],
    ));
  }
}
