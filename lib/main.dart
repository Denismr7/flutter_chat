import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/chat_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
              primarySwatch: Colors.blue,
            ),
            home: snapshot.hasError
                ? Center(
                    child: const Text('Something went wrong!'),
                  )
                : snapshot.connectionState == ConnectionState.done
                    ? ChatScreen()
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
          );
        });
  }
}
