import 'package:flutter/material.dart';
import 'package:reportes/Pages/home_page.dart';
import 'package:reportes/Providers/content_provider.dart';
import 'package:reportes/Common/preferences.dart';
import 'package:provider/provider.dart';
import 'package:reportes/Theme/main_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ContentProvider>(
        create: (_) => ContentProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final prefs = new Preferences();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContentProvider>(
      create: (BuildContext context) => ContentProvider(),
      child: Consumer<ContentProvider>(
        builder: (context, provider, __) {
          provider.initDarkMode(prefs.mode);
          return MaterialApp(
            title: 'Project 3738',
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            theme: MainTheme.setup(provider.darkMode),
          );
        },
      ),
    );
  }
}
