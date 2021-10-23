import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifehq/goals/add_goal_page.dart';
import 'package:lifehq/goals/goals.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/journal/journal.dart';
import 'package:lifehq/journal/journal_entry_input.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/knowledge/knowledge.dart';
import 'package:lifehq/knowledge/principles_crud.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/loading.dart';
import 'package:lifehq/momento_mori.dart';
import 'package:lifehq/on_boarding.dart';
import 'package:lifehq/principles.dart';
import 'package:lifehq/routine/routine_home.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/services/onboarding_provider.dart';
import 'package:lifehq/settings.dart';
import 'package:lifehq/utils/removed_glow_behavior.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
            create: (ctx) => OnboardingProvider(),
          ),
        ],
        child: Builder(builder: (context) {
          return Consumer5<RoutineService, GoalsService, JournalService,
              KnowledgeService, OnboardingProvider>(
            builder: (context, routineService, goalsService, journalService,
                knowledgeService, onboardingService, child) {
              return MaterialApp(
                  title: 'LifeHQ',
                  debugShowCheckedModeBanner: false,
                  routes: {
                    MomentoMori.routeName: (ctx) => MomentoMori(),
                    Principles.routeName: (ctx) => Principles(),
                    Home.routeName: (ctx) => Home(),
                    Settings.routeName: (ctx) => Settings(),
                    RoutineHome.routeName: (ctx) => RoutineHome(),
                    // RoutineDetails.routeName: (ctx) => RoutineDetails(), // dynamic route
                    Journal.routeName: (ctx) => Journal(),
                    // JournalEntryDetails.routeName: (ctx) => JournalEntryDetails(), // dynamic route
                    JournalEntryInput.routeName: (ctx) => JournalEntryInput(),
                    Goals.routeName: (ctx) => Goals(),
                    // GoalPage.routeName: (ctx) => GoalPage(), // dynamic route
                    AddGoalPage.routeName: (ctx) => AddGoalPage(),
                    Knowledge.routeName: (ctx) => Knowledge(),
                    PrinciplesCRUD.routeName: (ctx) => PrinciplesCRUD(),
                  },
                  theme: ThemeData.dark().copyWith(
                      colorScheme:
                          ColorScheme.dark().copyWith(primary: Colors.white)),
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
                          onboardingService.initilised)
                      ? onboardingService.firstTime
                          ? OnBoarding()
                          : MomentoMori()
                      : const Loading());
            },
          );
        }));
  }
}
