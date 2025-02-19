import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:friendlywar/screens/home/home.dart';
import 'package:friendlywar/screens/login.dart';
import 'package:friendlywar/screens/play/play.dart';
import 'package:friendlywar/screens/scoreBoard/score_board.dart';
import 'package:friendlywar/screens/welcome.dart';
import 'package:friendlywar/store/app.middleware.dart';
import 'package:friendlywar/store/app.reducer.dart';
import 'package:friendlywar/store/app.state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final store = Store(appReducer,
      initialState: AppState.initial(), middleware: appMiddleware());

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          "/": (context) => Welcome(),
          "/login": (context) => LoginScreen(),
          "/home": (context) => HomeScreen(),
          "/scoreboard": (context) => ScoreBoardScreen(),
        },
        onGenerateRoute: (settings) {
          final args = settings.arguments as dynamic;

          return MaterialPageRoute(builder: (context) {
            return PlayScreen(
              opponent: args?["opponent"],
            );
          });
        },
      ),
    );
  }
}
