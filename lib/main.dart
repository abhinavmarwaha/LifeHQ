import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:lifehq/goals/add_goal_page.dart';
import 'package:lifehq/goals/goals.dart';
import 'package:lifehq/goals/services/goals_service.dart';
import 'package:lifehq/home.dart';
import 'package:lifehq/journal/journal.dart';
import 'package:lifehq/journal/journal_entry_input.dart';
import 'package:lifehq/journal/services/journal_service.dart';
import 'package:lifehq/knowledge/knowledge.dart';
import 'package:lifehq/knowledge/knowledge_bits_folders.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    setDesktopSize();
  }
  bool crashes = await SettingsProvider.getSendCrashes();
  if (crashes)
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://debc6d1f10af4477bd0b46562e6e61b1@o1061543.ingest.sentry.io/6051931';
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => runApp(MyApp()),
    );
  else
    runApp(MyApp());
}

// sentryInit() async {
//   try {
//     throw Exception();
//   } catch (exception, stackTrace) {
//     await Sentry.captureException(
//       exception,
//       stackTrace: stackTrace,
//     );
//   }
// }

setDesktopSize() async {
  await DesktopWindow.setWindowSize(Size(600, 800));
  await DesktopWindow.setMinWindowSize(Size(600, 800));
  await DesktopWindow.setMaxWindowSize(Size(600, 800));
}

// TODO flow a little bit confusing
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => SettingsProvider(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => RoutineService(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => GoalsService(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => JournalService(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => KnowledgeService(),
          ),
          ChangeNotifierProvider(
            lazy: false,
            create: (ctx) => OnboardingProvider(),
          ),
        ],
        child: Builder(builder: (context) {
          // sentryInit();
          return Consumer6<RoutineService, GoalsService, JournalService,
              KnowledgeService, OnboardingProvider, SettingsProvider>(
            builder: (context, routineService, goalsService, journalService,
                knowledgeService, onboardingService, settingsService, child) {
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

                    KnowledgeBitsFolders.project: (ctx) =>
                        KnowledgeBitsFolders(cat: KnowledgeCat.project),
                    KnowledgeBitsFolders.area: (ctx) =>
                        KnowledgeBitsFolders(cat: KnowledgeCat.area),
                    KnowledgeBitsFolders.research: (ctx) =>
                        KnowledgeBitsFolders(cat: KnowledgeCat.research),
                    KnowledgeBitsFolders.archive: (ctx) =>
                        KnowledgeBitsFolders(cat: KnowledgeCat.archive),
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
                          onboardingService.initilised &&
                          settingsService.initilised)
                      ? onboardingService.firstTime
                          ? OnBoarding()
                          : MomentoMori()
                      : const Loading());
            },
          );
        }));
  }
}
