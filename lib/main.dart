import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:log_viewer/app_bloc_observer.dart';
import 'app.dart';

void main() {
  Bloc.observer = const AppBlocObserver();
  runApp(const LogViewerApp());
}
