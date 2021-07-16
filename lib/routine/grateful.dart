import 'package:flutter/material.dart';
import 'package:lifehq/routine/quote.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:provider/provider.dart';

class Grateful extends StatefulWidget {
  Grateful({Key key}) : super(key: key);

  @override
  _GratefulState createState() => _GratefulState();
}

class _GratefulState extends State<Grateful> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String treasure1;
  String treasure2;
  String treasure3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Grateful for?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          RoutineService routineService =
                              Provider.of<RoutineService>(context,
                                  listen: false);
                          routineService.goingOnRoutine.treasures = [];
                          routineService.goingOnRoutine.treasures
                              .add(treasure1);
                          routineService.goingOnRoutine.treasures
                              .add(treasure2);
                          routineService.goingOnRoutine.treasures
                              .add(treasure3);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (ctx) => Quote()));
                          
                        }
                      },
                      child: Icon(Icons.arrow_forward_ios))
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return "Need to fill this ASAP!";
                          return null;
                        },
                        onChanged: (value) => treasure1 = value),
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return "Need to fill this ASAP!";
                          return null;
                        },
                        onChanged: (value) => treasure2 = value),
                    TextFormField(
                        validator: (value) {
                          if (value.isEmpty) return "Need to fill this ASAP!";
                          return null;
                        },
                        onChanged: (value) => treasure3 = value),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
