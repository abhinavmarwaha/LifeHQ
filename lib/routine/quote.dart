import 'package:flutter/material.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class Quote extends StatefulWidget {
  const Quote({
    Key? key,
  }) : super(key: key);

  @override
  State<Quote> createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  String _quote = "";

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Daily Quote?",
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
          TextFormField(
            onFieldSubmitted: (value) => _submit(value, context),
            onChanged: (value) => _quote = value,
            cursorColor: Colors.white,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
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
    routineService.goingOnRoutine!.quote = value;
    routineService.saveRoutine().then((value) =>
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home())));
  }
}
