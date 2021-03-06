import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/functions.dart';
import 'package:lifehq/principles.dart';
import 'package:lifehq/services/onboarding_provider.dart';
import 'package:lifehq/services/settings_provider.dart';
import 'package:lifehq/skeleton.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class MomentoMori extends StatefulWidget {
  MomentoMori({Key? key}) : super(key: key);

  static const routeName = '/momento-mori';

  @override
  _MomentoMoriState createState() => _MomentoMoriState();
}

class _MomentoMoriState extends State<MomentoMori> {
  final whichBar = 2;
  double nextOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 4160), () {
      setState(() {
        nextOpacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _today = DateTime.now();
    final _yearStart = DateTime(_today.year);
    final _yearEnd = DateTime(_today.year + 1);

    final LocalAuthentication _localAuthentication = LocalAuthentication();

    return Skeleton(
      child: Consumer2<OnboardingProvider, SettingsProvider>(
        builder: (context, value, settings, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Momento Mori",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Spacer(),
                Opacity(
                  opacity: nextOpacity,
                  child: GestureDetector(
                      onTap: () {
                        settings.lockBool
                            ? _localAuthentication
                                .authenticate(localizedReason: "Unlock LifeHQ")
                                .then((value) => Navigator.pushNamed(
                                    context, Principles.routeName))
                            // screenLock<void>(
                            //     context: context,
                            //     correctString: settings.lockString,
                            //     canCancel: false,
                            //     didUnlocked: () => Navigator.pushNamed(
                            //         context, Principles.routeName),
                            //   )
                            : Navigator.pushNamed(
                                context, Principles.routeName);
                      },
                      child: Icon(Icons.arrow_forward_ios)),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Expanded(
                child: MoriCal(
              yearGoingOn: (_today.millisecondsSinceEpoch -
                      DateTime(value.year).millisecondsSinceEpoch) ~/
                  3.154e+10,
            )),
            SizedBox(
              height: 6,
            ),
            Text("Year"),
            SizedBox(
              height: 6,
            ),
            ProgressBar(
              progress: (_today.millisecondsSinceEpoch -
                      _yearStart.millisecondsSinceEpoch) /
                  (_yearEnd.millisecondsSinceEpoch -
                      _yearStart.millisecondsSinceEpoch),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
                '???Stop whatever you???re doing for a moment and ask yourself: Am I afraid of death because I won???t be able to do this anymore????')
          ],
        ),
      ),
    );
  }
}

class MoriCal extends StatelessWidget {
  const MoriCal({
    Key? key,
    required this.yearGoingOn,
  }) : super(key: key);

  final int yearGoingOn;

  final colCount = 10;
  final totalyears = 80;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: List.generate(
        totalyears ~/ colCount,
        (rowIn) => Row(
          children: List.generate(
              colCount,
              (colIn) => Week(
                    key: Key((rowIn * colCount + colIn).toString()),
                    index: rowIn * colCount + colIn,
                    color: (rowIn * colCount + colIn) >= yearGoingOn
                        ? (rowIn * colCount + colIn) == yearGoingOn
                            ? Colors.red
                            : Colors.white
                        : Colors.grey[900],
                  )),
        ),
      )),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    this.progress,
  });

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 3)),
      child: Align(
        alignment: Alignment.topLeft,
        child: FractionallySizedBox(
          widthFactor: progress,
          heightFactor: 1,
          child: ColoredBox(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class Week extends StatefulWidget {
  const Week({
    Key? key,
    this.color,
    this.index,
  }) : super(key: key);

  final Color? color;
  final int? index;

  @override
  _WeekState createState() => _WeekState();
}

class _WeekState extends State<Week> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: widget.index! * 100),
        curve: Curves.linear,
        opacity: opacity,
        child: Container(
          height: 30,
          width: 30,
          color: widget.color,
        ),
      ),
    );
  }
}
