import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../cubit/selector_cubit.dart';

class SelectorView extends StatelessWidget {
  const SelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectorCubit, DateTime>(
      builder: (context, state) {
        return Column(children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat('dd.MM')
                            .format(state.subtract(Duration(days: 3))))),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat('dd.MM')
                            .format(state.subtract(Duration(days: 2))))),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat('dd.MM')
                            .format(state.subtract(Duration(days: 1))))),
                    Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat('dd.MM').format(state))),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat('dd.MM')
                            .format(state.add(Duration(days: 1))))),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat('dd.MM')
                            .format(state.add(Duration(days: 2))))),
                    Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(DateFormat('dd.MM')
                            .format(state.add(Duration(days: 3))))),
                  ])),
          Divider(
            height: 1,
          )
        ]);
      },
    );
  }
}
