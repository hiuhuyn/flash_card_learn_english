import 'package:flash_card_learn_english/data/db_offline/topic_sqlite_db.dart';

import '../components/router/route_name.dart';

import 'flutter_gen/gen_l10n/app_localizations.dart';
import 'components/router/customer_route.dart';
import 'controllers/setting_app.dart';
import 'controllers/topic_controller.dart';
import 'controllers/topic_controller_offline.dart';
import 'controllers/vocabularys_controller.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await TopicSqlite.initDB();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => SettingApp()),
    ChangeNotifierProvider(create: (_) => TopicController()),
    ChangeNotifierProvider(create: (_) => VocabularysController()),
    ChangeNotifierProvider(create: (_) => TopicCtrlOffline()),
  ], child: const MyApp()));

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<SettingApp>().loadLocale();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Flat Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: context.watch<SettingApp>().locale,
      initialRoute: RouteName.defaultRouter,
      onGenerateRoute: CustomeRoute.generate,
    );
  }
}
