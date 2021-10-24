import 'package:flutter/material.dart';
import 'package:lifehq/constants/strings.dart';
import 'package:lifehq/routine/daily_quote.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class Grateful extends StatefulWidget {
  Grateful({Key? key, this.display = false}) : super(key: key);

  static const routeName = '/grateful';
  static const displayRoute = '/showGrateful';

  final bool display;

  @override
  _GratefulState createState() => _GratefulState();
}

class _GratefulState extends State<Grateful> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String treasure1 = "";
  String treasure2 = "";
  String treasure3 = "";

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Consumer<RoutineService>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.display ? "Was grateful for" : "Grateful for?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      if (widget.display) {
                        Navigator.pushNamed(context, DailyQuote.displayRoute);
                      } else if (_formKey.currentState!.validate()) {
                        Routine routine = value.goingOnRoutine!;
                        routine.treasures.add(treasure1);
                        routine.treasures.add(treasure2);
                        routine.treasures.add(treasure3);
                        Navigator.pushNamed(context, DailyQuote.routeName);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            if (widget.display)
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: value.routines.length > 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: value.routines.first.treasures
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    StringConstants.BULLET + e,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ))
                            .toList(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          StringConstants.BULLET + "This App 💖",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
              )
            else
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return "Need to fill this ASAP!";

                          return null;
                        },
                        onChanged: (value) => treasure1 = value),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return "Need to fill this ASAP!";

                          return null;
                        },
                        onChanged: (value) => treasure2 = value),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) return "Need to fill this ASAP!";

                          return null;
                        },
                        onChanged: (value) => treasure3 = value),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
