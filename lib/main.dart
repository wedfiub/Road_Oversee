import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:road_oversee/pages/welcome_screen.dart';
import 'package:road_oversee/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:road_oversee/pages/register_page.dart';
import 'package:road_oversee/pages/home_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
         WidgetTree()
  );
}class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}
class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
          stream: Auth().authStateChanges,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return HelloScreen();
            } else {
              return WelcomeScreen();
            }
          }
      ),
    );
  }
}





