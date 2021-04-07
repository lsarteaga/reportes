import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reportes/Pages/Login/signin_screen.dart';
import 'package:reportes/Pages/home_page.dart';
import 'package:reportes/Providers/content_provider.dart';
import 'package:reportes/Common/preferences.dart';
import 'package:provider/provider.dart';
import 'package:reportes/Theme/main_theme.dart';
import 'package:reportes/Models/User/user_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ContentProvider>(
        create: (_) => ContentProvider(),
      ),
      ChangeNotifierProvider(create: (_) => UserAuth())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final prefs = new Preferences();

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    UserAuth userAuth;

    return ChangeNotifierProvider<ContentProvider>(
      create: (BuildContext context) => ContentProvider(),
      child: Consumer<ContentProvider>(
        builder: (context, provider, __) {
          provider.initDarkMode(prefs.mode);
          return MaterialApp(
            title: 'Project 3738',
            debugShowCheckedModeBanner: false,
            home: FutureBuilder(
              future: _initialization,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                      child: Text('Error de inicio',
                          style: Theme.of(context).textTheme.headline3),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  userAuth = new UserAuth();
                  print('Firebase iniciado correctamente');
                  return (userAuth.auth.currentUser == null)
                      ? LoginScreen()
                      : HomePage();
                }
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              },
            ),
            theme: MainTheme.setup(provider.darkMode),
          );
        },
      ),
    );
  }
}
