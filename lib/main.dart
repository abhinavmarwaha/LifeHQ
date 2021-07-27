import 'package:flutter/material.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/loading.dart';
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
          ChangeNotifierProvider(
            create: (ctx) => GoalsService(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => JournalService(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => KnowledgeService(),
          ),
        ],
        child: Builder(builder: (context) {
          return Consumer4<RoutineService, GoalsService, JournalService,
              KnowledgeService>(
            builder: (context, routineService, goalsService, journalService,
                knowledgeService, child) {
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
                  home: (routineService.initilised &&
                          goalsService.initilised &&
                          journalService.initilised &&
                          knowledgeService.initilised)
                      ? Home()
                      : Loading());
            },
          );
        }));
  }
}
