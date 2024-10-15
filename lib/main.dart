import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'controller/controller.dart';
import 'controller/firebase_controller.dart';
import 'controller/sql_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ApiController(),
        ),
        ChangeNotifierProvider(
          create: (_) => DbController(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirestoreController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
