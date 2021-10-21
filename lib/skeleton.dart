import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ));
  }
}
