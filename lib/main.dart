import 'package:flutter/material.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/loading.dart';
import 'package:lifehq/momento_mori.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/services/notifications_provider.dart';
import 'package:lifehq/utils/removed_glow_behavior.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
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
          ChangeNotifierProvider(
            create: (ctx) => GoalsService(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => JournalService(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => KnowledgeService(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => NotificationsProvider(),
          ),
        ],
        child: Builder(builder: (context) {
          return Consumer5<RoutineService, GoalsService, JournalService,
              KnowledgeService, NotificationsProvider>(
            builder: (context, routineService, goalsService, journalService,
                knowledgeService, notificationsService, child) {
              // print(routineService.initilised.toString() +
              //     " " +
              //     goalsService.initilised.toString() +
              //     " " +
              //     journalService.initilised.toString() +
              //     " " +
              //     knowledgeService.initilised.toString() +
              //     " " +
              //     notificationsService.initilised.toString());

              return MaterialApp(
                  title: 'LifeHQ',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.dark(),
                  builder: (context, child) {
                    return ScrollConfiguration(
                      behavior: RemovedGlowBehavior(),
                      child: child!,
                    );
                  },
                  home: (routineService.initilised &&
                          goalsService.initilised &&
                          journalService.initilised &&
                          knowledgeService.initilised &&
                          notificationsService.initilised)
                      ? routineService.checkIfRoutined() != -1
                          ? MomentoMori()
                          : Home()
                      : const Loading());
            },
          );
        }));
  }
}
