import 'package:flutter/material.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:provider/provider.dart';

class Quote extends StatelessWidget {
  const Quote({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            Text(
              "Daily Quote?",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            TextFormField(
              onFieldSubmitted: (value) {
                final routineService =
                    Provider.of<RoutineService>(context, listen: false);
                routineService.goingOnRoutine!.quote = value;
                routineService.saveRoutine().then((value) => Navigator.push(
                    context, MaterialPageRoute(builder: (ctx) => Home())));
                
              },
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  suffix: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: "Type"),
            )
          ],
        )));
  }
}
