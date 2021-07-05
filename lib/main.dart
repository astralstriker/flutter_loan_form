import 'package:finmapp_assignment/app.dart';
import 'package:finmapp_assignment/di/inject.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
 
void main() {
  configureDependencies();
  runApp(ProviderScope(child: MyApp()));
}
