import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';// Assuming you have LaunchScreen
import 'package:sms_app/firebase_options.dart';
import 'package:sms_app/screens/launch_screen.dart.dart';
import 'package:sms_app/widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Check if the user is logged in
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(user: user));
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Navigate to home screen if user is logged in, otherwise to launch screen
      home: user != null ? HomeScreen() : const LaunchScreen(),
    );
  }
}
