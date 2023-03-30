import 'package:bloc/bloc.dart';

class SelectorCubit extends Cubit<DateTime> {
  SelectorCubit() : super(DateTime.now());

  void nextDay() => emit(state.add(Duration(days: 1)));
  void prevDay() => emit(state.add(Duration(days: -1)));
}
