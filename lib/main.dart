import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/loading_screen.dart';
import 'package:chat/screens/something_went_wrong_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:chat/screens/chat_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        backgroundColor: Colors.red,
        accentColor: Colors.green[900],
        accentColorBrightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.red,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        )
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (ctx, snapshot) {
          if(snapshot.hasError) {
            return SomethingWentWrongScreen();
          }

          if(snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if(userSnapshot.hasData) {
                  return ChatScreen();
                } else {
                  return AuthScreen();
                }
              },
            );
          }

          return LoadingScreen();
        },
      ),
    );
  }
}
