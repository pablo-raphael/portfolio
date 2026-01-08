import 'package:flutter/material.dart';
import 'package:portfolio/portfolio_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:portfolio/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const PortfolioApp());
}
