import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/routine/models/routine.dart';
import 'package:lifehq/routine/routine_details.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/utils/removed_glow_behavior.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => RoutineService(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp(
            title: 'LifeHQ',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            builder: (context, child) {
              return ScrollConfiguration(
                behavior: RemovedGlowBehavior(),
                child: child,
              );
            },
            home: RoutineDetails(
              routine: Routine(
                  routineId: 1,
                  routineType: 0,
                  dateTime: DateTime.now(),
                  feel: Emoji.byChar(Emojis.grinningCat),
                  rested: 0,
                  restedString: "Good night's sleep",
                  treasures: ["Home", "Family"]),
            ),
          );
        }));
  }
}
