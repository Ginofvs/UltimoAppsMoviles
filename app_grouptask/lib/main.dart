import 'package:app_grouptask/Provider/GoogleSignIn.dart';
import 'package:app_grouptask/firebase_options.dart';
import 'package:app_grouptask/view/HomePage.dart';
import 'package:app_grouptask/view/IntefacesAuth/Interfaces_Registro1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:app_grouptask/pages/home.dart';
//import 'package:flutter_application_241124/view/HomePage.dart';
import 'package:provider/provider.dart';



void main() {
  initializeFirebase();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    )
  );
}

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}


void initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: Provider.of<ThemeProvider>(context).themeData,

      initialRoute: "/",
      routes: {'/': (_) => HomePage(),
      "/Registro1": (_) => Registro1(),
      "/HomePage": (_) => Home()},
    )
  );
}