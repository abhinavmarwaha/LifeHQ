import 'package:flutter/material.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/principles.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class DailyQuote extends StatefulWidget {
  const DailyQuote({
    Key? key,
    this.display = false,
  }) : super(key: key);

  static const routeName = '/daily-qoute';
  static const displayRoute = '/display-qoute';

  final bool display;

  @override
  State<DailyQuote> createState() => _DailyQuoteState();
}

class _DailyQuoteState extends State<DailyQuote> {
  String _quote = "";

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.display ? "Today's Quote" : "Daily Quote?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    _submit(_quote, context);
                  },
                  child: Icon(Icons.arrow_forward_ios)),
            ],
          ),
          SizedBox(height: 16),
          if (widget.display)
            Text(Provider.of<RoutineService>(context, listen: false)
                        .routines
                        .length >
                    0
                ? Provider.of<RoutineService>(context, listen: false)
                    .routines
                    .first
                    .quote!
                : "Obstacle is the way.")
          else
            TextFormField(
              onFieldSubmitted: (value) => _submit(value, context),
              onChanged: (value) => _quote = value,
              cursorColor: Colors.white,
              decoration: InputDecoration(
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
      ),
    );
  }

  _submit(String value, BuildContext context) {
    final routineService = Provider.of<RoutineService>(context, listen: false);

    if (!widget.display) {
      routineService.goingOnRoutine!.quote = value;
    }

    routineService.saveRoutine().then((value) {
      Navigator.popUntil(
          context,
          (route) =>
              route.settings.name != null &&
              route.settings.name!.compareTo(Principles.routeName) == 0);
      Navigator.pushNamed(context, Home.routeName);
    });
  }
}
