import 'package:flutter/material.dart';
import 'package:lifehq/constants/dimensions.dart';
import 'package:lifehq/services/onboarding_provider.dart';
import 'package:lifehq/skeleton.dart';
import 'package:provider/provider.dart';

class OnBoarding extends StatefulWidget {
  OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _selectedYear = 2020;
  List<String> _principles = [''];

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      child: Column(
        children: [
          Text(
            "Birth Year",
            style: TextStyle(fontSize: Dimensions.BigText),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15)),
            height: 160,
            child: YearPicker(
              firstDate: DateTime.fromMillisecondsSinceEpoch(0),
              lastDate: DateTime.now(),
              onChanged: (DateTime value) {
                setState(() {
                  _selectedYear = value.year;
                });
              },
              selectedDate: DateTime(_selectedYear),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Principles",
            style: TextStyle(fontSize: Dimensions.BigText),
          ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: ListView(
                children: _principles
                        // ignore: unnecessary_cast
                        .map((e) => (Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (val) => e = val,
                                    cursorColor: Colors.white,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        hintText: "Principle"),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _principles.remove(e);
                                      });
                                    },
                                    child: Icon(Icons.cancel))
                              ],
                            )) as Widget)
                        .toList() +
                    [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _principles.add("");
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            width: double.infinity,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
          ),
          GestureDetector(
            onTap: () {
              Provider.of<OnboardingProvider>(context, listen: false)
                  .onBoardingCompleted(_selectedYear, _principles)
                  .then((value) => Navigator.pop(context));
            },
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                width: double.infinity,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Done 👍",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
