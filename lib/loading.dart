import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
        child: SizedBox(
          height: 360,
          child: Column(
            children: [
              Image.asset("assets/loading.gif"),
              SizedBox(
                height: 12,
              ),
              Text(
                '“Obstacle is the way”',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
