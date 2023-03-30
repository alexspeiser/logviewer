import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:log_viewer/logs/view/logs_list.dart';
import 'package:log_viewer/selector/cubit/selector_cubit.dart';

class SwipeDetector extends StatelessWidget {
  const SwipeDetector({super.key});

  @override
  Widget build(BuildContext context) {
    final dateCubit = context.select((SelectorCubit cubit) => cubit);
    String? swipeDirection;
    return SizedBox.expand(
        child: GestureDetector(
      onPanUpdate: (details) {
        swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
      },
      onPanEnd: (details) {
        if (swipeDirection == null) {
          return;
        }
        if (swipeDirection == 'left') {
          dateCubit.nextDay();
        }
        if (swipeDirection == 'right') {
          dateCubit.prevDay();
        }
      },
      child: LogsList(),
    ));
  }
}
