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
import 'package:lifehq/knowledge/knowledge_bits_list.dart';
import 'package:lifehq/knowledge/models/para/knowledge_cat.dart';
import 'package:lifehq/knowledge/principles_crud.dart';
import 'package:lifehq/knowledge/quotes.dart';
import 'package:lifehq/knowledge/services/knowledge_service.dart';
import 'package:lifehq/loading.dart';
import 'package:lifehq/momento_mori.dart';
import 'package:lifehq/on_boarding.dart';
import 'package:lifehq/principles.dart';
import 'package:lifehq/routine/daily_quote.dart';
import 'package:lifehq/routine/feel.dart';
import 'package:lifehq/routine/goal_sheet.dart';
import 'package:lifehq/routine/grateful.dart';
import 'package:lifehq/routine/rested.dart';
import 'package:lifehq/routine/routine_home.dart';
import 'package:lifehq/routine/services/routine_service.dart';
import 'package:lifehq/services/onboarding_provider.dart';
import 'package:lifehq/services/settings_provider.dart';
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

// TODO flow a little bit confusing
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => SettingsProvider(),
          ),
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
                    Quotes.routeName: (ctx) => Quotes(),
                    Home.routeName: (ctx) => Home(),
                    Settings.routeName: (ctx) => Settings(),
                    RoutineHome.routeName: (ctx) => RoutineHome(),
                    Feel.routeName: (ctx) => Feel(),
                    Rested.restedRoute: (ctx) => Rested(
                          title: "Rested?",
                        ),
                    Rested.productiveRoute: (ctx) => Rested(
                          title: "Productive?",
                        ),
                    // SingleWord.routeName: (ctx) => SingleWord(), // dynamic view
                    GoalSheet.routeName: (ctx) => GoalSheet(),
                    Grateful.routeName: (ctx) => Grateful(),
                    Grateful.displayRoute: (ctx) => Grateful(
                          display: true,
                        ),
                    DailyQuote.routeName: (ctx) => DailyQuote(),
                    DailyQuote.displayRoute: (ctx) => DailyQuote(
                          display: true,
                        ),
                    AddGoalPage.routineRoute: (ctx) => AddGoalPage(
                          inRoutine: true,
                        ),
                    // RoutineDetails.routeName: (ctx) => RoutineDetails(), // dynamic route
                    Journal.routeName: (ctx) => Journal(),
                    // JournalEntryDetails.routeName: (ctx) => JournalEntryDetails(), // dynamic route
                    JournalEntryInput.routeName: (ctx) => JournalEntryInput(),
                    Goals.routeName: (ctx) => Goals(),
                    // GoalPage.routeName: (ctx) => GoalPage(), // dynamic route
                    AddGoalPage.routeName: (ctx) => AddGoalPage(),
                    Knowledge.routeName: (ctx) => Knowledge(),
                    PrinciplesCRUD.routeName: (ctx) => PrinciplesCRUD(),

                    KnowledgeBitsList.project: (ctx) =>
                        KnowledgeBitsList(cat: KnowledgeCat.project),
                    KnowledgeBitsList.area: (ctx) =>
                        KnowledgeBitsList(cat: KnowledgeCat.area),
                    KnowledgeBitsList.research: (ctx) =>
                        KnowledgeBitsList(cat: KnowledgeCat.reasearch),
                    KnowledgeBitsList.archive: (ctx) =>
                        KnowledgeBitsList(cat: KnowledgeCat.archive),
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
