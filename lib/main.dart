import 'package:flutter/material.dart';
import 'package:todo_note/pages/home/home_view.dart';
import 'package:todo_note/pages/onboarding/onboarding_view.dart';
import 'package:todo_note/pages/splash/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TO DO',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashView.routeName,
      routes: {
        SplashView.routeName : (context)=> SplashView(),
        OnboardingView.routeName : (context)=> OnboardingView(),
        HomeView.routeName : (context)=> HomeView(),
      },
    );
  }
}

