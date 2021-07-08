import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/chat_screen.dart';
import './screens/auth_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'FlutterChat',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              backgroundColor: Colors.pink,
              accentColor: Colors.deepPurple,
              accentColorBrightness: Brightness.dark,
              buttonTheme: ButtonTheme.of(context).copyWith(
                buttonColor: Colors.pink,
                textTheme: ButtonTextTheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            home: snapshot.hasError
                ? Center(
                    child: const Text('Something went wrong!'),
                  )
                : snapshot.connectionState == ConnectionState.done
                    ? StreamBuilder(
                        stream: FirebaseAuth.instance.authStateChanges(),
                        builder: (ctx, snapshot) {
                          FirebaseMessaging.onBackgroundMessage(
                              _firebaseMessagingBackgroundHandler);
                          if (snapshot.hasData) {
                            return ChatScreen();
                          }
                          return AuthScreen();
                        })
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
          );
        });
  }
}
